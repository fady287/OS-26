#include "kheap.h"

#include <inc/memlayout.h>
#include <inc/dynamic_allocator.h>
#include <kern/conc/sleeplock.h>
#include <kern/proc/user_environment.h>
#include <kern/mem/memory_manager.h>
#include "../conc/kspinlock.h"
#include "../conc/ksemaphore.h"
#include <kern/cpu/cpu.h>
#include <inc/queue.h>

#define MAXXING KERNEL_HEAP_MAX

uint32 FirstGap = MAXXING;
uint32 LastGap  = MAXXING;

/************************************************************************************/
//==================================================================================//
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.GM#2] KERNEL HEAP - [0] GIVEN FUNCTIONS
//==============================================
// [1] INITIALIZE KERNEL HEAP:
//==============================================


/*
 * create structure to maintain the empty frame address + size
 * use bit in a frame to distinguish between buddy system page or normal one
 * in delete we need to merge
 * research about allocating and mapping
 * VA to MA and from MA to VA
 */


void kheap_init()
{
	//==================================================================================
	//DON'T CHANGE THESE LINES==========================================================
	//==================================================================================
	{
		buddy_init();
		set_kheap_strategy(KHP_PLACE_CUSTOMFIT);
		kheapPageAllocStart = KERNEL_HEAP_START;
		kheapPageAllocBreak = KERNEL_HEAP_START;
	}
	//==================================================================================
	//==================================================================================
}
/************************************************************************************/

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
/**************************************************/
/* BLOCK ALLOCATOR */
/**************************************************/

uint32 getindex(void *va){
	uint32 add = (uint32)va;
	uint32 index = (add-KERNEL_HEAP_START)/PAGE_SIZE;
	return index;
}

uint32 getaddr(uint32 index){
	return KERNEL_HEAP_START+index*PAGE_SIZE;
}

void remgap(uint32 curgap){
	if(next[curgap] != MAXXING) prev[next[curgap]] = prev[curgap];
	else LastGap = prev[curgap];
	if(prev[curgap] != MAXXING) next[prev[curgap]] = next[curgap];
	else FirstGap = next[curgap];
	next[curgap] = MAXXING;
	prev[curgap] = MAXXING;
}

void addgap(uint32 idxafter, uint32 curgap){
	prev[curgap] = idxafter;
	if(idxafter == MAXXING){
		next[curgap] = FirstGap;
		FirstGap = curgap;
	}
	else{
		next[curgap] = next[idxafter];
		next[idxafter] = curgap;
	}
	if(next[curgap] != MAXXING) prev[next[curgap]] = curgap;
	else LastGap = curgap;
}

void mapping(uint32 va, uint32 size){
	for(uint32 i = va; i < va+size; i += PAGE_SIZE){
		struct FrameInfo *newframe;
		allocate_frame(&newframe);
		map_frame(ptr_page_directory, newframe, i, PERM_WRITEABLE);
		uint32 x = to_frame_number(newframe);
		Frame_to_VA[x] = i;
	}
}

/**************************************************/
/* BLOCK ALLOCATOR */
/**************************************************/

void* create_buddy_space()
{
	uint32 va = (uint32)kmalloc(PAGE_SIZE);
	uint32 index = getindex((void*)va);
	buddy_system_block[index] = 1;
	return (void*)va;
}

void  delete_buddy_space(void *va)
{
	uint32 index = getindex(va);
	buddy_system_block[index] = 0;
	kfree(va);
}

/**************************************************/
/* PAGE ALLOCATOR */
/**************************************************/
void* kmalloc(unsigned int size)
{
	if(size <= DYN_ALLOC_MAX_BLOCK_SIZE) return alloc_block(size);
	if(size > KERNEL_HEAP_MAX-KERNEL_HEAP_START) return NULL;
	size = ROUNDUP(size, PAGE_SIZE);
	uint32 cur, mx = MAXXING;
	for(cur = FirstGap; cur != MAXXING; cur = next[cur])
	{
		if(sz[cur] == size){
			mx = cur;
			break;
		}
		if(mx == MAXXING || sz[mx] < sz[cur]) mx = cur;
	}
	if(mx != MAXXING && sz[mx] > size){
		uint32 ret = getaddr(mx);
		uint32 newsz = sz[mx]-size;
		uint32 newadd = mx+size/PAGE_SIZE;
		uint32 prv = prev[mx];
		remgap(mx);
		sz[mx] = size;
		sz[newadd] = newsz;
		addgap(prv, newadd);
		mapping(ret, size);
		return (void*)ret;
	}
	else if(mx != MAXXING && sz[mx] == size){
		uint32 ret = getaddr(mx);
		remgap(mx);
		sz[mx] = size;
		mapping(ret, size);
		return (void*)ret;
	}
	else{
		if(KERNEL_HEAP_MAX-kheapPageAllocBreak < size) return NULL;
		uint32 ret = kheapPageAllocBreak;
		uint32 index = getindex((void*)ret);
		sz[index] = size;
		kheapPageAllocBreak += size;
		mapping(ret, size);
		return (void*)ret;
	}

	/*EFFICIENT IMPLEMENTATION ~O(#FREE BLOCKS + #ALLOCATED PAGES) IS REQUIRED */
}

void kfree(void* virtual_address)
{
	uint32 va = (uint32)virtual_address;
	if(va < KERNEL_HEAP_START || va >= kheapPageAllocBreak) return;
	uint32 index = getindex((void*)va);
	if(buddy_system_block[index]){
		free_block(virtual_address);
		return;
	}
	uint32 size = sz[index];
	for(uint32 i = va; i < va+size; i += PAGE_SIZE){
		uint32 *meh = NULL;
		struct FrameInfo *frame = get_frame_info(ptr_page_directory, i, &meh);
		if(frame == 0){
			unmap_frame(ptr_page_directory, i);
			continue;
		}
		if(frame != NULL){
			uint32 x = to_frame_number(frame);
			Frame_to_VA[x] = 0;
			unmap_frame(ptr_page_directory, i);
		}
	}
	uint32 cur = index;
	uint32 forcur, insertidx = MAXXING;
	for(forcur = FirstGap; forcur != MAXXING; forcur = next[forcur]){
		if(forcur < cur) insertidx = forcur;
		else break;
	}
	addgap(insertidx, cur);
	uint32 nxt = next[cur];
	uint32 prv = prev[cur];
	if(nxt != MAXXING){
		if(cur+sz[cur]/PAGE_SIZE == nxt){
			sz[cur] += sz[nxt];
			sz[nxt] = 0;
			remgap(nxt);
		}
	}
	if(prv != MAXXING){
		if(prv+sz[prv]/PAGE_SIZE == cur){
			sz[prv] += sz[cur];
			sz[cur] = 0;
			remgap(cur);
			cur = prv;
		}
	}
	while(LastGap != MAXXING){
		uint32 tmp = LastGap;
		if(getaddr(tmp)+sz[tmp] != kheapPageAllocBreak) break;
		kheapPageAllocBreak = getaddr(tmp);
		remgap(tmp);
		sz[tmp] = 0;
	}
	/*EFFICIENT IMPLEMENTATION ~O(#FREE BLOCKS + #FREED PAGES) IS REQUIRED */
}

unsigned int kheap_physical_address(unsigned int virtual_address)
{
	uint32 *meh=NULL;
	struct FrameInfo *frame = get_frame_info(ptr_page_directory, virtual_address, &meh);
	if(frame==NULL) return 0;
	return to_physical_address(frame) + (virtual_address % PAGE_SIZE);
	/*EFFICIENT IMPLEMENTATION ~O(1) IS REQUIRED */
}

unsigned int kheap_virtual_address(unsigned int physical_address)
{
	uint32 x = to_frame_number(to_frame_info(physical_address));
	if(Frame_to_VA[x]==0) return 0;
	return Frame_to_VA[x] + (physical_address % PAGE_SIZE);
	/*EFFICIENT IMPLEMENTATION ~O(1) IS REQUIRED */
}

//=================================================================================//
//============================== BONUS FUNCTION ===================================//
//=================================================================================//
// krealloc():

//	Attempts to resize the allocated space at "virtual_address" to "new_size" bytes,
//	possibly moving it in the heap.
//	If successful, returns the new virtual_address, in which case the old virtual_address must no longer be accessed.
//	On failure, returns a null pointer, and the old virtual_address remains valid.

//	A call with virtual_address = null is equivalent to kmalloc().
//	A call with new_size = zero is equivalent to kfree().
void *krealloc(void *virtual_address, uint32 new_size)
{
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - krealloc
	//Your code is here
	//Comment the following line
	panic("krealloc() is not implemented yet...!!");
}

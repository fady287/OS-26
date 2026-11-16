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
	size = ROUNDUP(size, PAGE_SIZE);
	if(size > KERNEL_HEAP_MAX-KERNEL_HEAP_START) return NULL;
	struct FreeGaps *cur, *mx = NULL;
	LIST_FOREACH(cur, &FreeGapsList, FreeGaps)
	{
		if(cur->size == size){
			mx = cur;
			break;
		}
		if(mx == NULL || mx->size < cur->size) mx = cur;
	}
	if(mx != NULL && mx->size > size){
		uint32 ret = mx->start;
		uint32 index = getindex((void*)ret);
		sz[index] = size;
		for(uint32 i = ret; i < ret+size; i += PAGE_SIZE){
			struct FrameInfo *newframe;
			allocate_frame(&newframe);
			map_frame(ptr_page_directory, newframe, i, PERM_WRITEABLE);
			uint32 x = to_frame_number(newframe);
			Frame_to_VA[x] = i;
		}
		mx->size -= size;
		mx->start += size;
		return (void*)ret;
	}
	else if(mx != NULL && mx->size == size){
		uint32 ret = mx->start;
		uint32 index = getindex((void*)ret);
		sz[index] = size;
		for(uint32 i = ret; i < ret+size; i += PAGE_SIZE){
			struct FrameInfo *newframe;
			allocate_frame(&newframe);
			map_frame(ptr_page_directory, newframe, i, PERM_WRITEABLE);
			uint32 x = to_frame_number(newframe);
			Frame_to_VA[x] = i;
		}
		LIST_REMOVE(&FreeGapsList, mx);
		return (void*)ret;

	}
	else{
		if(KERNEL_HEAP_MAX-kheapPageAllocBreak < size) return NULL;
		else{
			uint32 ret = kheapPageAllocBreak;
			uint32 index = getindex((void*)ret);
			sz[index] = size;
			kheapPageAllocBreak += size;
			for(uint32 i = ret; i < ret+size; i += PAGE_SIZE){
				struct FrameInfo *newframe;
				allocate_frame(&newframe);
				map_frame(ptr_page_directory, newframe, i, PERM_WRITEABLE);
				uint32 x = to_frame_number(newframe);
				Frame_to_VA[x] = i;
			}
			return (void*)ret;
		}
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
	sz[index] = 0;
	for(uint32 i = va; i < va+size; i += PAGE_SIZE){
		uint32 *meh=NULL;
		struct FrameInfo *frame = get_frame_info(ptr_page_directory, i, &meh);
		if(frame == 0){
			unmap_frame(ptr_page_directory, i);
			continue;
		}
		uint32 x = to_frame_number(frame);
		Frame_to_VA[x] = 0;
		unmap_frame(ptr_page_directory, i);
	}
	struct FreeGaps *forcur, *insertidx = NULL;
	LIST_FOREACH(forcur, &FreeGapsList, FreeGaps){
		if(forcur->start+forcur->size < va) insertidx = forcur;
		else break;
	}
	struct FreeGaps *cur = NULL;
	if(insertidx == NULL) LIST_INSERT_HEAD(&FreeGapsList, cur);
	else LIST_INSERT_AFTER(&FreeGapsList, insertidx, cur);
	cur->size = size;
	cur->start = va;
	struct FreeGaps *nxt = cur->prev_next_info.le_next;
	struct FreeGaps *prv = cur->prev_next_info.le_prev;
	if(nxt != NULL){
		uint32 idx = (nxt->start-KERNEL_HEAP_START)/PAGE_SIZE;
		if(!buddy_system_block[idx] && cur->start+cur->size+1 == nxt->start){
			cur->size += nxt->size;
			LIST_REMOVE(&FreeGapsList, nxt);
		}
	}
	if(prv != NULL){
		uint32 idx = (prv->start-KERNEL_HEAP_START)/PAGE_SIZE;
		if(!buddy_system_block[idx] && prv->start+prv->size+1 == cur->start){
			prv->size += cur->size;
			LIST_REMOVE(&FreeGapsList, cur);
		}
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

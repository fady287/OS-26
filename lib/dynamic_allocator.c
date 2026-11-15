/*
 * dynamic_allocator.c
 *
 *  Created on: Sep 21, 2023
 *      Author: HP
 */
#include <inc/assert.h>
#include <inc/string.h>
#include "../inc/dynamic_allocator.h"

/************************************************************************************/
//==================================================================================//
//============================== GIVEN FUNCTIONS ===================================//
//==================================================================================//
//TODO: [PROJECT'26.GM#1] DYNAMIC ALLOCATOR - [0] GIVEN FUNCTIONS
//==================================
// [1] INITIALIZE BUDDY FREE LISTS:
//==================================
void buddy_init()
{
	//panic("buddy_init is not implemented yet");

	for (int l = BUDDY_LOWER_LEVEL; l <= BUDDY_UPPER_LEVEL; ++l)
	{
		LIST_INIT(&(freeBlockLists[l]));
	}
}
//====================================
// [2] PRINT SIZE OF FREE LISTS:
//====================================
void PrintFreeBlockLists()
{
	for (int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL; ++i)
	{
		cprintf("Level#%d: %d\n", i, LIST_SIZE(&freeBlockLists[i]));
	}
}
/************************************************************************************/

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
//===========================
// [1] GET BLOCK SIZE:
//===========================
__inline__ uint32 get_block_size(void *va)
{
	uint32 meta = (uint32) va - META_DATA_SIZE;
	struct BlockMetaData *cur = (struct BlockMetaData *)meta;
	uint32 lvl = cur->level;
	return BLOCK_SIZE(lvl);

}
//===========================
// [2] ALLOCATE BLOCK:
//===========================
void *alloc_block(uint32 requiredSize)
{
	if(requiredSize==0) return NULL;
	uint32 realsize = requiredSize + META_DATA_SIZE;
	uint32 level;
	for(int i = BUDDY_LOWER_LEVEL; i <= BUDDY_UPPER_LEVEL;i++){
		if(BLOCK_SIZE(i)>=realsize){
			level=i;
			break;
		}
	}
	uint32 first_free_level;
	bool found = 0;
	for(int i =level;i<=BUDDY_UPPER_LEVEL;i++){
		if(LIST_SIZE(&freeBlockLists[i])>0){
			found = 1;
			first_free_level=i;
			break;
		}
	}
	if(found==0){

		void *address = create_buddy_space();
		if(address==NULL) return NULL;

		uint32 iaddress=(uint32) address;
		struct BlockMetaData *cur= (struct BlockMetaData*) address;
		uint32 bAddress = iaddress + BLOCK_SIZE(BUDDY_UPPER_LEVEL);
		struct BlockMetaData *buddy= (struct BlockMetaData*)bAddress;
		cur -> is_free=1;
		cur -> level = BUDDY_UPPER_LEVEL;
		buddy -> is_free=1;
		buddy -> level= BUDDY_UPPER_LEVEL;
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],buddy);
		LIST_INSERT_HEAD(&freeBlockLists[BUDDY_UPPER_LEVEL],cur);
		first_free_level=BUDDY_UPPER_LEVEL;
	}


	while(first_free_level > level){
		struct BlockMetaData *cur = LIST_FIRST(&freeBlockLists[first_free_level]);
		LIST_REMOVE(&freeBlockLists[first_free_level],cur);
		uint32 bAdress= (uint32)cur ^ BLOCK_SIZE((first_free_level-1));
		struct BlockMetaData *buddy = (struct BlockMetaData*) bAdress;
		buddy->level=first_free_level-1;
		buddy->is_free=1;
		cur->is_free=1;
		cur->level=first_free_level-1;
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],buddy);
		LIST_INSERT_HEAD(&freeBlockLists[first_free_level-1],cur);
		first_free_level--;
	}
	struct BlockMetaData *ret = LIST_FIRST(&freeBlockLists[level]);
	LIST_REMOVE(&freeBlockLists[level],ret);
	ret -> is_free=0;
	void *ret_adress= (void *)((uint32) ret+META_DATA_SIZE);
	return ret_adress;
}

//===================================================
// [3] FREE BLOCK WITH COALESCING:
//===================================================
void free_block(void *va)
{
	uint32 curAddress = (uint32) va - META_DATA_SIZE;
	struct BlockMetaData *cur = (struct BlockMetaData *)curAddress;
	cur->is_free = 1;

	while(cur->level <= BUDDY_UPPER_LEVEL){
		void *tva = (void *)(curAddress + META_DATA_SIZE);
		uint32 buddyAddress = curAddress ^ get_block_size(tva);
		struct BlockMetaData *buddy = (struct BlockMetaData *)buddyAddress;
		if(buddy->is_free == 1 && buddy->level == cur->level){
			if(buddyAddress<curAddress) curAddress = buddyAddress;
			LIST_REMOVE(&freeBlockLists[buddy->level], buddy);
			cur = (struct BlockMetaData *)curAddress;
			cur->level = buddy->level+1;
		}
		else break;
	}
	if(cur->level > BUDDY_UPPER_LEVEL){
		void *tva = (void *)(curAddress + META_DATA_SIZE);
		delete_buddy_space(tva);
	}
	else LIST_INSERT_HEAD(&freeBlockLists[cur->level], cur);
}

//=================================================================================//
//============================== BONUS FUNCTION ===================================//
//=================================================================================//

//===========================
// [1] REALLOCATE BLOCK:
//===========================
void *realloc_block(void* va, uint32 newSize)
{
	//TODO: [PROJECT'26.BONUS#1] KERNEL REALLOC - realloc_block
	//Your code is here
	//Comment the following line
	panic("realloc_block() Not implemented yet");
}

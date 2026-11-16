#ifndef FOS_KERN_KHEAP_H_
#define FOS_KERN_KHEAP_H_

#ifndef FOS_KERNEL
# error "This is a FOS kernel header; user programs should not #include it"
#endif

#include <inc/types.h>
#include <inc/queue.h>
#include <inc/memlayout.h>

/*2017*/
//Values for user heap placement strategy
#define KHP_PLACE_CONTALLOC 0x0
#define KHP_PLACE_FIRSTFIT 	0x1
#define KHP_PLACE_BESTFIT 	0x2
#define KHP_PLACE_NEXTFIT 	0x3
#define KHP_PLACE_WORSTFIT 	0x4
#define KHP_PLACE_CUSTOMFIT 0x5

/******************************************************************************/
//TODO: [PROJECT'26.GM#2] KERNEL HEAP - [0] GIVEN DATA
uint32 kheapPageAllocStart ;
uint32 kheapPageAllocBreak ;
uint32 kheapPlacementStrategy;
/******************************************************************************/

/*2025*/ //Replaced by setter & getter function
static inline void set_kheap_strategy(uint32 strategy){kheapPlacementStrategy = strategy;}
static inline uint32 get_kheap_strategy(){return kheapPlacementStrategy ;}

//***********************************
void kheap_init();

void* kmalloc(unsigned int size);
void kfree(void* virtual_address);
void *krealloc(void *virtual_address, unsigned int new_size);

unsigned int kheap_virtual_address(unsigned int physical_address);
unsigned int kheap_physical_address(unsigned int virtual_address);

LIST_HEAD(GapInfo_List, FreeGaps);
typedef LIST_ENTRY(FreeGaps) Gap_LIST_entry_t;

struct FreeGaps {
	Gap_LIST_entry_t prev_next_info;
	uint32 start;
	uint32 size;
};

struct GapInfo_List FreeGapsList;

int numOfKheapVACalls;

uint32 sz[NUM_OF_KHEAP_PAGES+5];
uint32 buddy_system_block[NUM_OF_KHEAP_PAGES+5];

#endif // FOS_KERN_KHEAP_H_

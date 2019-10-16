/* Copyright 2014 DEI - Universita' di Bologna
   author       DEI - Universita' di Bologna
                Alessandro Capotondi - alessandro.capotondi@unibo.it
   info         Simple Malloc based on FREERTOS Heap_4.c mode */

#ifndef _RT_MALLOC_DATA_H_
#define _RT_MALLOC_DATA_H_

#include "rt/rt_api_io.h"
#include "rt_data.h"

/* Define the linked list structure.  This is used to link free blocks in order
 *of their memory address. */
typedef struct A_BLOCK_LINK
{
    struct A_BLOCK_LINK *pxNextFreeBlock;   /*<< The next free block in the list. */
    unsigned int xBlockSize;                      /*<< The size of the free block. */
} plp_BlockLink_t;

typedef struct plp_heap_desc_s
{  
    plp_BlockLink_t xstart;
    plp_BlockLink_t *pxend;
    
    unsigned int xFreeBytesRemaining;
    unsigned int xMinimumEverFreeBytesRemaining;
    unsigned int xBlockAllocatedBit;
    
    unsigned int *lock;
} plp_alloc_t;

/*
 * --------------------------------------------------------------
 * Configuration
 * --------------------------------------------------------------
 */

/* Assumes 8bit bytes! */
#define heapBITS_PER_BYTE                       ( ( unsigned int ) 8 )

#define portBYTE_ALIGNMENT                      (4)
#define portBYTE_ALIGNMENT_MASK                 ( ( unsigned int ) 0x0003 )
#define portPOINTER_SIZE_TYPE                   (int *)

/* The size of the structure placed at the beginning of each allocated memory
 *block must by correctly byte aligned. */
#define xHeapStructSize                         ((sizeof(plp_BlockLink_t) + (portBYTE_ALIGNMENT-1)) & ~portBYTE_ALIGNMENT_MASK )

/* Block sizes must not get too small. */
#define heapMINIMUM_BLOCK_SIZE                  ( ( unsigned int ) ( xHeapStructSize * 2 ) )

/*
 * --------------------------------------------------------------
 * Global Variables
 * --------------------------------------------------------------
 */

/* Create a couple of list links to mark the start and end of the list. */
// BlockLink_t xStart, *pxEnd = NULL;
#define xStart(heap)                                  (heap->xstart)
#define pxEnd(heap)                                   (heap->pxend)

/* Keeps track of the number of free bytes remaining, but says nothing about
 *fragmentation. */
// unsigned int xFreeBytesRemaining = 0U;
// unsigned int xMinimumEverFreeBytesRemaining = 0U;
#define xFreeBytesRemaining(heap)                     (heap->xFreeBytesRemaining)
#define xMinimumEverFreeBytesRemaining(heap)          (heap->xMinimumEverFreeBytesRemaining)

/* Gets set to the top bit of an unsigned int type.  When this bit in the xBlockSize
 * member of an BlockLink_t structure is set then the block belongs to the
 * application.  When the bit is free the block is still part of the free heap
 * space. */
// unsigned int xBlockAllocatedBit = 0;
#define xBlockAllocatedBit(heap)                 (heap->xBlockAllocatedBit)

#define vTaskSuspendAll(heap)
    
#define xTaskResumeAll(heap)

#define configASSERT(x) \
{\
    if( ! (x)) {\
        exit(1);\
        while(1);\
    }\
}
//      printf("[Malloc] Error: assert failed at file %s line %d\n",__FILE__, __LINE__);

#define traceMALLOC(addr,size) \
{\
}
  //  printf("[Malloc] Allocated heap at 0x%x (size %d)\n", addr, size);

#define traceFREE(addr,size) \
{\
}
    //printf("[FREE] Free of 0x%x (block size %d)\n", addr, size);

extern plp_alloc_t PLP_FC_DATA heapl2ram;

extern plp_alloc_t PLP_L1_DATA heapsram;

#ifdef SCM_SIZE
extern plp_alloc_t PLP_L1_DATA heapscm;
#endif

#endif


// Highest priority is 0
#define BARRIER         0
#define GP0             1
#define GP1             2
#define GP2             3

#define TMR0            4
#define TMR1            5
#define TMR2            6
#define TMR3            7

#define DMA             8

#define EVENT_GPIO      9
#define EVENT_SPIM0    10
#define EVENT_SPIM1    11
#define EVENT_UART     12
#define EVENT_I2C      13
#define EVENT_I2S      14
#define EVENT_I2S_CAM  15

#define EVENT_HWCE     17

#define EVTMASK_BARRIER  (1 <<  0)
#define EVTMASK_GP0      (1 <<  1)
#define EVTMASK_GP1      (1 <<  2)
#define EVTMASK_GP2      (1 <<  3)
#define EVTMASK_TMR0     (1 <<  4)
#define EVTMASK_TMR1     (1 <<  5)
#define EVTMASK_TMR2     (1 <<  6)
#define EVTMASK_TMR3     (1 <<  7)
#define EVTMASK_DMA      (1 <<  8)
#define EVTMASK_GPIO     (1 <<  9)
#define EVTMASK_SPIM0    (1 << 10)
#define EVTMASK_SPIM1    (1 << 11)
#define EVTMASK_UART     (1 << 12)
#define EVTMASK_I2C      (1 << 13)
#define EVTMASK_I2S      (1 << 14)
#define EVTMASK_I2S_CAM  (1 << 15)
#define EVTMASK_HWCE     (1 << 17)




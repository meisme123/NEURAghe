#!/usr/bin/python

# ////////////////////////////////////////////////////////////////////////////////
# // Company:        Multitherman Laboratory @ DEIS - University of Bologna     //
# //                    Viale Risorgimento 2 40136                              //
# //                    Bologna - fax 0512093785 -                              //
# //                                                                            //
# // Engineer:       Davide Rossi - davide.rossi@unibo.it                       //
# //                                                                            //
# // Additional contributions by:                                               //
# //                 Andreas Traber - atraber@student.ethz.ch                   //
# //                                                                            //
# // Create Date:    05/04/2013                                                 //
# // Design Name:    ULPSoC                                                     //
# // Project Name:   ULPSoC                                                     //
# // Language:       tcl, now python                                            //
# //                                                                            //
# // Description:    s19 to slm conversion tool for stxp70 cluster compilation  //
# //                                                                            //
# // Revision:                                                                  //
# // Revision v0.1 - File Created                                               //
# // Revision v0.2 - Modification: Compiler does now generate little endian     //
# //                 directly. revert bytes!                                    //
# // Revision v0.3 - Moved from 128 bit s19 to 8 bit s19 file. This solves our  //
# //                 problems with misaligned addresses in s19 files.           //
# // Revision v0.4 - Added TCDM memory initialization                           //
# // Revision v0.5 - Rewrote the whole thing in python as tcl cannot handle     //
# //                 long file names properly
# ////////////////////////////////////////////////////////////////////////////////

import sys
import math


###############################################################################
# Function to dump single bytes of a string to a file
###############################################################################
def dump_bytes( filetoprint, addr, data_s):
    for i in xrange(0,4,1):
        filetoprint.write("@%08X %s\n" % ( addr+i,  data_s[i*2:(i+1)*2] ))

###############################################################################
# Read s19 file and put data bytes into a dictionary
###############################################################################
def s19_parse(filename, s19_dict):
    s19_file = open(filename, 'r')
#    cont = 0
    for line in s19_file:
        rec_field = line[:2]
        prefix    = line[:4]

        if rec_field == "S0" or prefix == "S009" or prefix == "S505" or prefix == "S705" or prefix == "S017" or prefix == "S804" or line == "":
            continue

        data = line[-6:-4] # extract data byte. It counts \r\n chars also.
        str_addr = line[4:-6]

        addr = int("0x%s" % str_addr, 0)

        s19_dict[addr] = data
#        if cont<10 and data!="00":
#          print line
#          print data
#          print str_addr
#          cont = cont+1

    s19_file.close()

###############################################################################
# arrange bytes in words
###############################################################################
def bytes_to_words(byte_dict, word_dict):
    for addr in byte_dict:
        wordaddr = addr >> 2
        data = "00000000"

        if wordaddr in word_dict:
            data = word_dict[wordaddr]

        byte = addr % 4
        byte0 = data[0:2]
        byte1 = data[2:4]
        byte2 = data[4:6]
        byte3 = data[6:8]
        new   = byte_dict[addr]

        if byte == 0:
            data = "%s%s%s%s" % (byte0, byte1, byte2, new)
        elif byte == 1:
            data = "%s%s%s%s" % (byte0, byte1, new,   byte3)
        elif byte == 2:
            data = "%s%s%s%s" % (byte0, new,   byte2, byte3)
        elif byte == 3:
            data = "%s%s%s%s" % (new,   byte1, byte2, byte3)

        word_dict[wordaddr] = data

###############################################################################
# Start of file
###############################################################################
if(len(sys.argv) < 2):
    print "Usage s19toslm.py FILENAME"
    quit()

word_size     = 4 # word size of the smaller port: 4 Bytes or 8 bytes
mem_size      = 262144*8 #mem_size in bytes. The depth depends on the port width
ramloop_width = 2 #bytes


mem_depth    = mem_size / word_size

# total_l2_size_in_bytes = word_size * mem_depth

l2_ramloop_size = 4096 # in bytes
l2_ramloops_rows     = mem_depth / l2_ramloop_size/ramloop_width

#print l2_ramloops_rows

l2_start     = 0x1C000000
l2_end       = l2_start + l2_ramloops_rows * l2_ramloop_size * word_size - 1

tcdm_banks     = 8
tcdm_bank_size = 2048 # in words (32 bit)
tcdm_start     = 0x10000000
tcdm_end       = tcdm_start + tcdm_banks * tcdm_bank_size * 4 - 1
tcdm_bank_bits = int(math.log(tcdm_banks, 2))


###############################################################################
# Parse s19 file
###############################################################################
s19_dict = {}
slm_dict = {}

#s19_parse("/home/nur/aaa.s19", s19_dict)
s19_parse(sys.argv[1], s19_dict)

bytes_to_words(s19_dict, slm_dict)



# word align all addresses
l2_start   = l2_start   >> 2
l2_end     = l2_end     >> 2
tcdm_start = tcdm_start >> 2
tcdm_end   = tcdm_end   >> 2
# actual size of L2 and TCDM (for flash)
l2_size     = 0
tcdm_size   = 0
l2_blocks   = 0
tcdm_blocks = 0

###############################################################################
# open files
###############################################################################
l2_cut_files = {}
for i in range(0, l2_ramloops_rows):
    l2_cut_files[i] = {}
    for j in range (0, word_size):
      l2_cut_files[i][j] = open("l2_ram_cut%d_%d.slm" % (i,j), 'w')

tcdm_files = {}
for i in range(0, tcdm_banks):
    tcdm_files[i] = open("tcdm_bank%d.slm" % i, 'w')

tcdm_file = open("tcdm.slm", 'w')

l2_stim = open("l2_stim.slm",    'w')
flash   = open("flash_stim.slm", 'w')

###############################################################################
# write the stimuli
###############################################################################
#cont=0

for addr in sorted(slm_dict.keys()):
    data = int(slm_dict[addr], 16)
    # l2 address range
    if(addr >= l2_start and addr <= l2_end):
        l2_base = addr - l2_start
        cut     = l2_base >> (int(math.log(l2_ramloop_size/2, 2) + (word_size/4-1)))
        byte    = addr % 8
        
        #print ("cut: %d" %(cut))
        
        l2_addr = (l2_base >> (word_size/4)) % (l2_ramloop_size/2)
        #if (cont<10):
        #  print ("addr: %x, %x, data: %s" %(l2_base, l2_addr, data))
          
        #cont=cont+1
        
        l2_size += 1
        for b in range(0, 2):
          if (l2_base % (word_size/4)==0):
            l2_cut_files[cut][b  ].write("@%08X %04x\n" % (l2_addr, (data>>(b*16))&0xFFFF))
          else:
            l2_cut_files[cut][4+b].write("@%08X %02x\n" % (l2_addr, (data>>(b*8))&0xFF))
        l2_stim.write("@%08X %08x\n" % (l2_base, data))


    # tcdm address range
    if(addr >= tcdm_start and addr <= tcdm_end):
        tcdm_addr = (addr - tcdm_start) >> tcdm_bank_bits
        bank      = addr % tcdm_banks
        tcdm_files[bank].write("@%08X %x\n" % (tcdm_addr, data))
        tcdm_size += 1

        tcdm_file.write("@%08X %x\n" % ((addr - tcdm_start), data))
    

###############################################################################
# write flash
###############################################################################

# 4KB blocks
l2_blocks   = (l2_size/1024+1)
tcdm_blocks = (tcdm_size/1024+1)
header_size = 8<<2

l2_off_s    = "%08X"%(((tcdm_size+8)/1024 + 1)*1024 <<2)
l2_start_s  = "%08X"%(l2_start << 2)
l2_size_s   = "%08X"%(l2_size << 2)
l2_blocks_s = "%08X"%(l2_blocks)

tcdm_off_s    = "%08X"%(header_size)
tcdm_start_s  = "%08X"%(tcdm_start << 2)
tcdm_size_s   = "%08X"%(tcdm_size << 2)
tcdm_blocks_s = "%08X"%(tcdm_blocks)


# write header
dump_bytes(flash, 0,  l2_off_s)
dump_bytes(flash, 4,  l2_start_s)
dump_bytes(flash, 8,  l2_size_s)
dump_bytes(flash, 12, l2_blocks_s)
dump_bytes(flash, 16, tcdm_off_s)
dump_bytes(flash, 20, tcdm_start_s)
dump_bytes(flash, 24, tcdm_size_s)
dump_bytes(flash, 28, tcdm_blocks_s)

# write data
for addr in sorted(slm_dict.keys()):
    data = slm_dict[addr]

    # l2 address range
    if(addr >= l2_start and addr <= l2_end):
        l2_base = (addr - l2_start)
        l2_addr = l2_base  + ((tcdm_size+8)/1024+1)*1024
        dump_bytes(flash, l2_addr * 4, data)

    # tcdm address range
    if(addr >= tcdm_start and addr <= tcdm_end):
        tcdm_addr = (addr - tcdm_start)

        dump_bytes(flash, tcdm_addr * 4 + header_size, data)

###############################################################################
# close all files
###############################################################################

for i in range(0, l2_ramloops_rows):
    for j in range (0, word_size):
      l2_cut_files[i][j].close()



for i in tcdm_files:
    tcdm_files[i].close()

tcdm_file.close()

l2_stim.close()
flash.close()

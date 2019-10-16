#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

##########################################################################################################
#                                                                                                        #
#               EOLAB @ DIEE - Università degli studi di Cagliari                                        # 
#                           Via marengo 2 - 09123                                                        #
#                                   Cagliari                                                             #
#                                                                                                        #
#                                                                                                        #
# Engineer:       Gianfranco Deriu - gian.deriu@gmail.com                                                #
#                                                                                                        #
#                                                                                                        #
# Project:        NEURAGHE                                                                               #
# File:           post_training.py                                                                       #  
# Description:    this script processes the weigths and the biases to be suitables for NEURAGHE platform #                            
#                                                                                                        #
##########################################################################################################

# ██████╗  ██████╗ ███████╗████████╗
# ██╔══██╗██╔═══██╗██╔════╝╚══██╔══╝      
# ██████╔╝██║   ██║███████╗   ██║   
# ██╔═══╝ ██║   ██║╚════██║   ██║   
# ██║     ╚██████╔╝███████║   ██║        
# ╚═╝      ╚═════╝ ╚══════╝   ╚═╝         
# ████████╗██████╗  █████╗ ██╗███╗   ██╗██╗███╗   ██╗ ██████╗ 
# ╚══██╔══╝██╔══██╗██╔══██╗██║████╗  ██║██║████╗  ██║██╔════╝ 
#    ██║   ██████╔╝███████║██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗
#    ██║   ██╔══██╗██╔══██║██║██║╚██╗██║██║██║╚██╗██║██║   ██║
#    ██║   ██║  ██║██║  ██║██║██║ ╚████║██║██║ ╚████║╚██████╔╝
#    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
import sys, math, ctypes, struct, json
from pt_lib import *

_default_NROW_ = 1  #4
_default_NCOL_ = 1  #4

_WS_SIZE_      = 12  #36? 
_BIAS_POS_     = 9   #27
  
class _SG_:
  size = 0
  base_addr = 0
  
  
  
def zeros_fill_5x5 (dest, offset, n, b): #FIXME
  for i in range (0, n):
    if i%n == n-1:
      dest[offset+i] =b
      #print "bias %d " % b
    else:
      dest[offset+i] =0
    
  return

def dispose_weights_5x5 (w_disp, offset, w_lin, bias):
  for i in range (0, 25):
    w_disp[offset+i] = w_lin[i]
  
  w_disp[offset+25]= 0;
  w_disp[offset+26]= 0;
  w_disp[offset+_BIAS_POS_]= bias;
  w_disp[offset+28]= 0;
  w_disp[offset+29]= 0;
  w_disp[offset+30]= 0;
  w_disp[offset+31]= 0;
  return


def copy_w (dest, offset, src, n):
  for i in range(0, n):      
    dest [offset+i]=src[i]
  return  
 

  
def copy (dest, src, d, s, n):
  for i in range(0, n):      
    dest [d+i]=src[s+i]
  return  
  
  
def transpose (dst, src, r, c, el_size):
  for i in range (0, c):
    for j in range (0, r):
      s= (j*c+i)*el_size
      d= (i*r+j)*el_size
      copy (dst, src, d, s, el_size)
      
  return    
  
def subdivide (dest, src, IG, OG, maxOG, nrow, ncol):
  nsop= nrow*ncol
  temp = [0]*len(dest)
 
  
  SG = OG/maxOG
  if OG%maxOG>0:
    SG+=1
    
 # sg_list=[]
 # for sg in range (0, SG):
  
 #   new_sg= _SG_()
    
 #   if OG>=(sg+1)*maxOG:
 #       new_sg.size = maxOG
 #     else:
 #       new_sg.size = (OG - sg*maxOG)
    
  #  new_sg.base_addr = sg*maxOG*IG*nsop*_WS_SIZE_
    
  #  sg_list.append(new_sg)
  
   
  
 # for sg in sg_list:
 #   transpose(dest[sg.base_addr:], src[sg.base_addr:], sg.size, IG/ncol, ncol * _WS_SIZE_)  
  
  for sg in range (0, SG):
    for ig in range (0, IG):
      if OG>=(sg+1)*maxOG:
        GR = maxOG
      else:
        GR = OG - sg*maxOG
        
        
        
      for og in range (0, GR):
        for i in range (0, nrow):
          s = (IG*ncol)*i + (IG*nsop) *og  + ncol     *ig     + sg*maxOG*IG*nsop
          d =      ncol*i +     nsop  *og  + nsop *GR *ig     + sg*maxOG*IG*nsop
          #print ("%d -> %d"%(s,d))
          if temp [d*_WS_SIZE_]!= 0:
            print "overwriting!! d= %d" % d
            #print temp [d*_WS_SIZE_]
            print ig
            print og
            print sg
	    print temp
            sys.exit(1)
            
          copy (temp, src, d*_WS_SIZE_, s*_WS_SIZE_, _WS_SIZE_*ncol)
       #   copy (dest, src, d*_WS_SIZE_, s*_WS_SIZE_, _WS_SIZE_*nrow)
          
 # print temp
  
  for sg in range (0, SG):
    for ig in range (0, IG):
      if OG>=(sg+1)*maxOG:
        GR = maxOG
      else:
        GR = OG - sg*maxOG
        
        
        
      for og in range (0, GR):
        for i in range (0, nsop):
          s=    i + nsop*og        + ig*GR*nsop + sg*IG*maxOG*nsop
          d= GR*i +    og            + ig*GR*nsop + sg*IG*maxOG*nsop
         # print ("%d -> %d"%(s,d))
          if dest [d*_WS_SIZE_]!= 0:
            print "Overwriting!! d= %d" % d
            print dest [d*_WS_SIZE_]
            print ig
            print og
            print sg
            sys.exit(1)
          copy (dest, temp, d*_WS_SIZE_, s*_WS_SIZE_, _WS_SIZE_)
  return

#**********************************
# ███╗   ███╗ █████╗ ██╗███╗   ██╗ 
# ████╗ ████║██╔══██╗██║████╗  ██║ 
# ██╔████╔██║███████║██║██╔██╗ ██║ 
# ██║╚██╔╝██║██╔══██║██║██║╚██╗██║ 
# ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║ 
# ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ 
#**********************************     


print tcolors.OKBLUE+ tcolors.BOLD + "\t########################"+ tcolors.ENDC
print tcolors.OKBLUE+ tcolors.BOLD + "\t# Post-training script #"+ tcolors.ENDC
print tcolors.OKBLUE+ tcolors.BOLD + "\t########################\n"+ tcolors.ENDC

if len(sys.argv)==1:
    print tcolors.ERROR + "[ERROR] you must specify settings file!" + tcolors.ENDC
    print "usage: \n\tpost_trainig settings_file"
    sys.exit(1)
else:
  if len(sys.argv) == 2:
    settings_file = sys.argv[1]
  else:
    print tcolors.ERROR + "[ERROR] too many parameters!" + tcolors.ENDC
    print "usage: \n\tpost_trainig settings_file"
    sys.exit(1)


settings = parse_settings(settings_file)
        
        
if 'in_binfile' not in settings:  
  print tcolors.ERROR + "[ERROR] in_binfile not defined! Add to setting files in_binfile = 0  # or 1" + tcolors.ENDC
  sys.exit(1)
  


if 'out_binfile' not in settings:
  out_binfile = settings['in_binfile']
else:
  out_binfile = settings['out_binfile']
  
if 'NROW' not in settings:
  NROW = _default_NROW_
  print tcolors.WARNING + "[WARNING] NROW parameter not found. Using default: %d" %(NROW) + tcolors.ENDC
else:
  NROW = settings['NROW']  
  
if 'NCOL' not in settings:
  NCOL = _default_NCOL_
  print tcolors.WARNING + "[WARNING] NCOL parameter not found. Using default: %d" %(NCOL) + tcolors.ENDC
else:
  NCOL = settings['NCOL'] 
  
print tcolors.OK +"[OK] Settings read!"     + tcolors.ENDC


  
#print settings
if ('QF_o' in settings) and ('QF_i' in settings):
  QF_i = settings['QF_i']
  QF_o = settings['QF_o']
else:
  QF_i = settings['QF']
  QF_o = settings['QF']

print "\t QF_i: %d" % QF_i
print "\t QF_o: %d" % QF_o

if ('data_type_o' in settings) and ('data_type_i' in settings):
  data_type_o = settings['data_type_o'] # It must be i (int 4 B), h (short 2 B) or b (char 1 B)
  data_type_i = settings['data_type_i'] # It must be i (int 4 B), h (short 2 B) or b (char 1 B)
else:
  if 'data_type' not in settings:
    print tcolors.ERROR + "[ERROR] data_type not defined! Add to setting files data_type = 'd'  # or f or i" + tcolors.ENDC
    sys.exit(1)
  data_type_o = 'h' # It must be i (int 4 B), h (short 2 B) or b (char 1 B)
  data_type_i = settings['data_type'] # It must be i (int 4 B), h (short 2 B) or b (char 1 B)
      

NUM_LAYERS = 1

if 'layers_params' in settings:
  print tcolors.WARNING + "\t\t####################" + tcolors.ENDC
  print tcolors.WARNING + "\t\t# !ITERATIVE MODE! #" + tcolors.ENDC
  print tcolors.WARNING + "\t\t####################\n" + tcolors.ENDC
  with open( settings['layers_params'], "r") as f:
    layers= f.readlines()
  
  layers = [row for row in layers if row.strip() != ''] 
  
  for row in layers: 
    if row[0] != '{':
      print tcolors.ERROR +"[ERROR] The JSON file must have one layer per row!\n"   + tcolors.ENDC
      sys.exit(1)
          
  NUM_LAYERS = len(layers)   
  if NUM_LAYERS>0:
    print tcolors.OK +"[OK] File %s contains %d layers.\n" % (settings['layers_params'], NUM_LAYERS)     + tcolors.ENDC
  else:
    print tcolors.ERROR +"[ERROR] Empty file!.\n"   + tcolors.ENDC
    sys.exit(1)
    
  out_path = "./pt"
  if not os.path.isdir(out_path):
     os.makedirs(out_path)
  


   
yesAll=0
for l in range (0, NUM_LAYERS):
    
  
  
  if 'layers_params' not in settings:
    w_file = settings['w_file']
    b_file = settings['b_file']
    dest_file = settings['dest_file']
    
    maxOG = settings['maxOG']  
    FS = settings['FS']
    IF = settings['IF']
    OF = settings['OF']
  else:
    json_layer=json.loads(layers[l])
    print tcolors.OKBLUE + "\n\n ####################################"   + tcolors.ENDC
    print tcolors.OKBLUE + "               Layer %s" % (json_layer["name"])  + tcolors.ENDC
    print tcolors.OKBLUE + " ####################################\n\n"   + tcolors.ENDC
    print layers[l]
    
    w_file = json_layer["weights"]["file"]
    b_file = json_layer["bias"]["file"]
    dest_file = out_path +"/"+ w_file 
    try:
      maxOG = json_layer["maxog"]
    except ValueError, e:
      print tcolors.ERROR +"[ERROR] You must define the maxog value per each layer!.\n"   + tcolors.ENDC
    fw = json_layer["weights"]["size"][3]
    fh = json_layer["weights"]["size"][2]
    IF = json_layer["weights"]["size"][1]
    OF = json_layer["weights"]["size"][0]
    
    FS = fw
  
    if (fw!=fh):
      print tcolors.WARNING + "[WARNING] Layer %d skipped because the kernel is not square: %dx%d" %(l,fw,fh) + tcolors.ENDC
      continue
  
    if 'convert_1x1' in settings:
      if settings['convert_1x1']==1:
        convert1x1 = 1
      else:
        convert1x1 = 0
    else:
      convert1x1 = 0
      
    if FS==1 and convert1x1==0:
      print tcolors.WARNING + "[WARNING] Layer %d skipped because kernel size is: %d and convertion 1x1 to 3x3 is disabled" %(l,FS) + tcolors.ENDC
      continue
      
  
    if (FS!=1 and FS!=3 and FS!=5):
      print tcolors.WARNING + "[WARNING] Layer %d skipped because kernel size is: %d" %(l,FS) + tcolors.ENDC
      continue 


  print "\t FS: %d" % FS  
  print "\t IF: %d" % IF  
  print "\t OF: %d\n" % OF
    
  if settings['in_binfile']==0:
    with open(w_file, "r") as f:
      lw=len(f.readlines())
    with open(b_file, "r") as f:
      lb=len(f.readlines())
  else:  
    if data_type_i == 'd' :  
      data_size=8
    else:
      if data_type_i=='f':
        data_size=4
      else:
        if data_type_i=='h':
          data_size=2
	else:
	  if data_type_i=='b':
	    data_size=1
          else:
            print tcolors.ERROR + "[ERROR] data_type error. It must be d (double 8 B), f (float 4 B), i (int 4 B) or h (short 2 B)" + tcolors.ENDC
            sys.exit(1)  
    lw = os.stat(w_file).st_size/data_size
    lb = os.stat(b_file).st_size/data_size
    
    
    
  if lw != IF * OF * FS * FS:
    print tcolors.ERROR + "[ERROR] uncorrect lenght of weights file!" + tcolors.ENDC
    print "\texpected: %d , given: %d. Maybe wrong data format?" %( IF * OF * FS * FS , lw)
    sys.exit(1)
  else: 
    print tcolors.OK + "\t[OK] Weight file size is coerent with settings parameters!" + tcolors.ENDC
    
  if lb != OF:
    print tcolors.ERROR + "[ERROR] uncorrect lenght of biases file!" + tcolors.ENDC
    print "\texpected: %d , given: %d. Maybe wrong data format?" %( OF , lb)
    sys.exit(1)
  else: 
    print tcolors.OK + "\t[OK] Biases file size is coerent with settings parameters!" + tcolors.ENDC
   
        



  #TODO check if src are coerent with settings

  if FS==5:
    minIF=NCOL
  else:
    minIF=NCOL*3
    
  if_round=IF/minIF
  if IF%minIF>0:
    if_round+=1
  if_round=if_round*minIF

  of_round=OF/NROW
  if OF%NROW>0:
    of_round+=1

  of_round=of_round*NROW

 # WS = if_round*NCOL/minIF*of_round
  WS=if_round*of_round
  
  IG=if_round/minIF
  OG=of_round/NROW


  w            = [0]*(FS*FS*IF*OF)
  w_disp       = [0]*(_WS_SIZE_*(WS+2))
 # w_disp       = [0]*(_WS_SIZE_*WS) #ridefinito per il trasferimento di 2 filtri a zero, vd weights arrangement e la scrittura su file
  w_zerofilled = [0]*(_WS_SIZE_*WS)
  b            = [0]*(OF)
  wb_inter     = [0]*(_WS_SIZE_*WS)
  wb_subd      = [0]*(_WS_SIZE_*WS)



  if settings['in_binfile']==0:
    with open(w_file, "r") as f:
        w = f.readlines()
        
    print tcolors.OK + "\t[OK] Plain text weights loaded!" + tcolors.ENDC
    print "\t src: " + w_file  + "\n"

    with open(b_file, "r") as f:
        b = f.readlines()

    print tcolors.OK + "\t[OK] Plain text biases loaded!" + tcolors.ENDC
    print "\t src: " + b_file  + "\n"
  else:
    with open(w_file, "rb") as f:    
      word = f.read(data_size)
      i=0;
      while word != "":
          d= struct.unpack(data_type_i,word)
          w[i]=d[0]
          i=i+1
          word = f.read(data_size)
    
    with open(b_file, "rb") as f:    
      word = f.read(data_size)
      i=0;
      while word != "":
          d= struct.unpack(data_type_i,word)        
          b[i]=d[0]
          i=i+1
          word = f.read(data_size)
    
    
  #rotate weights

  if 'rotate' in settings: 
    print tcolors.OKBLUE + "Kernel rotation..." + tcolors.ENDC 
    wr  = [0]*(FS*FS*IF*OF)
    if settings['rotate']==1:
      for i in range (0, OF):
        print_pb(i, OF)
        for j in range (0, IF):
          for k in range (0, FS*FS):
            wr[i*IF*FS*FS + j*FS*FS + k] = w[i*IF*FS*FS + j*FS*FS + FS*FS-1-k]
      w = wr  
      print tcolors.OK + "\t[OK] Weights rotate complete!\n" + tcolors.ENDC
    
    
    
        
  
 # ____        _       _____                    ____                              _             
 #|  _ \  __ _| |_ __ |_   _|   _ _ __   ___   / ___|___  _ ____   _____ _ __ ___(_) ___  _ __  
 #| | | |/ _` | __/ _` || || | | | '_ \ / _ \ | |   / _ \| '_ \ \ / / _ \ '__/ __| |/ _ \| '_ \ 
 #| |_| | (_| | || (_| || || |_| | |_) |  __/ | |__| (_) | | | \ V /  __/ |  \__ \ | (_) | | | |
 #|____/ \__,_|\__\__,_||_| \__, | .__/ \___|  \____\___/|_| |_|\_/ \___|_|  |___/_|\___/|_| |_|
 #                          |___/|_|                                                            
                                                
  print tcolors.OKBLUE + "Datatype convertion..." + tcolors.ENDC
  if data_type_i=='d' or data_type_i=='f':
    w = [convert_float_to_short(i, data_type_o, QF_o) for i in w]
    b = [convert_float_to_short(i, data_type_o, QF_o) for i in b]
    with open(w_file+".plain.pthex", "w") as f:
      for we in w:
        f.write("0x%x\n" % ctypes.c_uint32(we).value)
    with open(w_file+".plain", "w") as f:
      for we in w:
        f.write("%d\n" % ctypes.c_int32(we).value)
        
    with open(b_file+".pthex", "w") as f:
      for bi in b:
        f.write("0x%x\n" % ctypes.c_uint32(bi).value)
    with open(b_file+".plain", "w") as f:
      for bi in b:
        f.write("%d\n" % ctypes.c_int32(bi).value)
           
    print tcolors.OK + "\t[OK] Convertion float to int (%c) done!\n" % (data_type_o) + tcolors.ENDC
  else:
    if data_type_i == data_type_o:
      w = [int(i) for i in w]
      b = [int(i) for i in b]
      print tcolors.OK + "\t[OK] Casting to int (%c) done!\n"%(data_type_i) + tcolors.ENDC
    else:
     # print checksum_fl(w,QF_i)
     # w1=w
      w = [convert_int_to_int(i, data_type_i, QF_i, data_type_o, QF_o) for i in w]
     # print checksum_fl(w,QF_o)
      
    #  for i in range (0,10000):
    #    if w[i]!=0:
    #      print "%08x %08x" % (w1[i],w[i])
    #  sys.exit(0)
      
      b = [convert_int_to_int(i, data_type_i, QF_i, data_type_o, QF_o) for i in b]
      print (tcolors.OK + "[OK] Conversion int (%c) to int (%c) done!\n"%(data_type_i, data_type_o)+ tcolors.ENDC) 
  
  
  if 'convert_1x1' in settings:
    if settings['convert_1x1']==1:
      if FS==1:
        print tcolors.OKBLUE + "Kernel conversion from 1x1 to 3x3..." + tcolors.ENDC
        w1to3 = [0]*(3*3*IF*OF)
        for o in range (0, OF):
          for i in range (0, IF):
            for wei in range (0, 9):
              if wei == 4:
                w1to3[o*IF*9 + i*9 + wei] = w[o*IF + i]
              else:
                w1to3[o*IF*9 + i*9 + wei] = 0
        w=w1to3
        FS=3
        print tcolors.OK + "\t[OK] 1x1 to 3x3 conversion done!" + tcolors.ENDC
    

  #   __        __   _       _     _                                                               _   
  #   \ \      / /__(_) __ _| |__ | |_ ___    __ _ _ __ _ __ __ _ _ __   __ _ _ __ ___   ___ _ __ | |_ 
  #    \ \ /\ / / _ \ |/ _` | '_ \| __/ __|  / _` | '__| '__/ _` | '_ \ / _` | '_ ` _ \ / _ \ '_ \| __|
  #     \ V  V /  __/ | (_| | | | | |_\__ \ | (_| | |  | | | (_| | | | | (_| | | | | | |  __/ | | | |_ 
  #      \_/\_/ \___|_|\__, |_| |_|\__|___/  \__,_|_|  |_|  \__,_|_| |_|\__, |_| |_| |_|\___|_| |_|\__|
  #                    |___/                                            |___/                                                                             
  #with open(settings['dest_file']+".plain.pthex", "w") as f:
  #  for wb in w:
  #    f.write("0x%x\n" % ctypes.c_uint32(wb).value)
  print tcolors.OKBLUE + "Weights arrangment..." + tcolors.ENDC
  if FS==5:
    for o in range (0, of_round):
      print_pb(o, of_round)
      if o<OF:
        for i in range (0, if_round):
          if i<IF:
            dispose_weights_5x5 (w_disp, (o*if_round + i)*_WS_SIZE_, w[(o*IF + i)*25:], b[o])
          else:
            zeros_fill_5x5 (w_disp, (o*if_round + i)*_WS_SIZE_, _WS_SIZE_, b[o])      
      else:
        zeros_fill_5x5 (w_disp, (o*if_round)*_WS_SIZE_, _WS_SIZE_*if_round, 0)



  if FS==3:  
    #FILTERS FITTING  
    
    for o in range (0, of_round):
      print_pb(o, of_round)
      if o<OF:
        for i in range ( 0, if_round):
              for www in range (0, 9):
                if i<IF:
                  w_disp[ o*IF*NCOL*_WS_SIZE_ + i*NCOL*_WS_SIZE_ +www] = w[o*IF*9 + i*NCOL*9 + www]
                else:
                  w_disp[ o*IF*NCOL*_WS_SIZE_ + i*NCOL*_WS_SIZE_ +www] =0
      else:
        for www in range (0, _WS_SIZE_*NCOL*IF):
          w_disp[ o*IF*NCOL*_WS_SIZE_ +www] = 0

    for o in range (0,2):
      for www in range (0,12):
         w_disp[_WS_SIZE_*(WS+o)+www] = 0
          
      
    #ADDING BIASES
    for o in range (0, of_round):
      for i in range (0, IF):
        if o<OF:
          w_disp[o*IF*_WS_SIZE_ + i*_WS_SIZE_ + _BIAS_POS_] = b[o];
        else:        
          w_disp[o*IF*_WS_SIZE_ + i*_WS_SIZE_ + _BIAS_POS_] = 0;



  if FS==5:
    print tcolors.OK + "\t[OK] 5x5 weights arrangment done!" + tcolors.ENDC
  else:
    print tcolors.OK + "\t[OK] 3x3 weights arrangment done!" + tcolors.ENDC
  print "\t\t Round to %d IF: %d" % (minIF, if_round)
  print "\t\t Round to %d OF: %d\n" % (NROW, of_round)  


  



  #    ____        _         _ _       _     _             
  #   / ___| _   _| |__   __| (_)_   _(_)___(_) ___  _ __  
  #   \___ \| | | | '_ \ / _` | \ \ / / / __| |/ _ \| '_ \ 
  #    ___) | |_| | |_) | (_| | |\ V /| \__ \ | (_) | | | |
  #   |____/ \__,_|_.__/ \__,_|_| \_/ |_|___/_|\___/|_| |_|
  #                                                                                        
  print tcolors.OKBLUE + "Subdividing..." + tcolors.ENDC
  print "\t maxOG: %d\n" % maxOG  
  #subdivide(wb_subd,w_disp,IG,OG,maxOG, NROW, NCOL)
  wb_subd = w_disp
  print tcolors.OK + "\t[OK] Subdividing done!" + tcolors.ENDC

  #print wb_subd


  #    _____ _ _                      _ _   _             
  #   |  ___(_) | ___  __      ___ __(_) |_(_)_ __   __ _ 
  #   | |_  | | |/ _ \ \ \ /\ / / '__| | __| | '_ \ / _` |
  #   |  _| | | |  __/  \ V  V /| |  | | |_| | | | | (_| |
  #   |_|   |_|_|\___|   \_/\_/ |_|  |_|\__|_|_| |_|\__, |
  #                                                 |___/ 

  


  print tcolors.OKBLUE + "File writing..." + tcolors.ENDC
  if 'layers_params' not in settings:
    # hex format file
    yesAll=check_files(dest_file+".pthex",yesAll)    
    with open(dest_file+".pthex", "w") as f:
    #  for wb in wb_subd:
       for wb in w_disp:
        f.write("0x%x\n" % ctypes.c_uint32(wb).value)

    # header file
    yesAll=check_files(settings['dest_file_h'],yesAll) 
    with open(settings['dest_file_h'], "w") as f:
        f.write("short int %s []={\n" %settings['array_name'])
        for i in range (0,len(wb_subd)-1):
          f.write("%d,\n"%wb_subd[i])
        f.write("%d};\n"%wb_subd[len(wb_subd)-1]) 
     # for i in range (0,len(w_disp)-1):
       # f.write("%d,\n"%w_disp[i])
       # f.write("%d};\n"%w_disp[len(w_disp)-1])   
    
    if out_binfile==1:
      # bin file
      yesAll=check_files(dest_file+".bin",yesAll)
      with open(dest_file+".bin", "wb") as f:
        #for wb in wb_subd:
        for wb in w_disp:
          data=struct.pack(data_type_o, wb)
          f.write(data)
    else:
      # txt file
      yesAll=check_files(dest_file,yesAll)
      with open(dest_file, "w") as f:
        #for wb in wb_subd:
        for wb in w_disp:
          f.write("%d\n" % wb)    
      

    print tcolors.OK + "\t[OK] Files successfully created!" + tcolors.ENDC
    print "\t\t text file:   " + dest_file
    print "\t\t header file: " + settings['dest_file_h']
    
  else:

    if out_binfile==1: 
      # bin file
      yesAll=check_files(dest_file,yesAll)
      with open(dest_file, "wb") as f:
        #for wb in wb_subd:
        for wb in w_disp:
          data=struct.pack(data_type_o, wb)
          f.write(data)
    else:
      # txt file
      yesAll=check_files(dest_file,yesAll)
      with open(dest_file, "w") as f:
        for wb in wb_subd:
          f.write("%d\n" % wb)    
      

    print tcolors.OK + "\t[OK] Files successfully created!" + tcolors.ENDC
    print "\t\t folder:   " + out_path
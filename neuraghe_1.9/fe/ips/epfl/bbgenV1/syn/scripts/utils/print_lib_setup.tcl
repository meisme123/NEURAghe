puts "\033\[32m    __________________________________________________________    \033\[0m"
puts "\033\[32m   |                                                          |   \033\[0m"
puts "\033\[32m   | STARTING SYNTHESIS with $NUM_CORES COREs                          |   \033\[0m"
puts "\033\[32m    ----------------------------------------------------------    \033\[0m"
puts "\033\[32m   |                                                          |   \033\[0m"
if { $USE_PB0 == "TRUE" } {  puts "\033\[32m   | USE PB0    = \[X\]                                         |\033\[0m"   } else { 
                             puts "\033\[32m   | USE PB0    = \[ \]                                         |\033\[0m"   }
if { $USE_PB4 == "TRUE" } {  puts "\033\[32m   | USE PB4    = \[X\]                                         |\033\[0m"   } else { 
                             puts "\033\[32m   | USE PB4    = \[ \]                                         |\033\[0m"   }
if { $USE_PB10 == "TRUE" } {  puts "\033\[32m   | USE PB10   = \[X\]                                         |\033\[0m"   } else { 
                             puts "\033\[32m   | USE PB10   = \[ \]                                         |\033\[0m"   }
if { $USE_PB16 == "TRUE" } {  puts "\033\[32m   | USE PB16   = \[X\]                                         |\033\[0m"   } else { 
                             puts "\033\[32m   | USE PB16   = \[ \]                                         |\033\[0m"   }
puts "\033\[32m    ----------------------------------------------------------    \033\[0m"
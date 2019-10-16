#!/bin/tcsh

source scripts/colors.sh

echo "${Green}--> Compiling APB SPI MASTER INTERFACE... ${NC}"

# check if environment variables are defined
if (! $?MSIM_LIBS_PATH ) then
  echo "${Red} MSIM_LIBS_PATH is not defined ${NC}"
  exit 1
endif

if (! $?IPS_PATH ) then
  echo "${Red} IPS_PATH is not defined ${NC}"
  exit 1
endif


echo "${Green}library: apb_spi_master_lib ${NC}"
rm -rf ${MSIM_LIBS_PATH}/apb_spi_master_lib

vlib ${MSIM_LIBS_PATH}/apb_spi_master_lib
vmap apb_spi_master_lib ${MSIM_LIBS_PATH}/apb_spi_master_lib

echo "${Green}Compiling component:   ${Brown} apb_spi_master ${NC}"
echo "${Red}"


vlog -work apb_spi_master_lib -quiet -sv ${IPS_PATH}/apb_peripherals/apb_spi_master/spi_master_apb_if.sv     || exit 1
vlog -work apb_spi_master_lib -quiet -sv ${IPS_PATH}/apb_peripherals/apb_spi_master/spi_master_clkgen.sv     || exit 1
vlog -work apb_spi_master_lib -quiet -sv ${IPS_PATH}/apb_peripherals/apb_spi_master/spi_master_fifo.sv       || exit 1
vlog -work apb_spi_master_lib -quiet -sv ${IPS_PATH}/apb_peripherals/apb_spi_master/spi_master_rx.sv         || exit 1
vlog -work apb_spi_master_lib -quiet -sv ${IPS_PATH}/apb_peripherals/apb_spi_master/spi_master_tx.sv         || exit 1
vlog -work apb_spi_master_lib -quiet -sv ${IPS_PATH}/apb_peripherals/apb_spi_master/spi_master_controller.sv || exit 1
vlog -work apb_spi_master_lib -quiet -sv ${IPS_PATH}/apb_peripherals/apb_spi_master/apb_spi_master.sv        || exit 1

echo "${Cyan}--> APB SPI MASTER INTERFACE compilation complete! ${NC}"


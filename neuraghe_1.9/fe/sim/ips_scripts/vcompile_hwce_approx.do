#!/bin/tcsh
source scripts/colors.sh

echo "${Green}--> Compiling  HWCE Wrapper... ${NC}"

rm -rf ${MSIM_LIBS_PATH}/hwce_lib

vlib ${MSIM_LIBS_PATH}/hwce_lib
vmap hwce_lib ${MSIM_LIBS_PATH}/hwce_lib

echo "${Green}Compiling component:   ${Brown} hwce_lib ${NC}"
echo "${Red}"

set INCDIRS='+incdir+${IPS_PATH}/hwpe/hwpe-sm/rtl/axi/ +incdir+${IPS_PATH}/hwpe/hwpe-sm/rtl +incdir+${IPS_PATH/hwpe/hwce/rtl} +incdir+./../rtl/includes'

set HWPE_SM_DIR='hwpe/hwpe-sm/rtl'


# compile hwce
vlog -quiet +define+$1 -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_linebuffer_fifo.sv             || exit 1
#vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_muls.sv                        || exit 1
#vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_addertree.sv                   || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_engine_fsm.sv                  || exit 1
#vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_insert_px.sv                   || exit 1
#vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_drop_px.sv                     || exit 1
vlog -quiet +define+$1 -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_engine.sv                      || exit 1
vlog -quiet +define+$1 -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_sop.sv                      || exit 1
#vlog -quiet +define+$1 -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/tree.sv                      || exit 1
# compile weight loader
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/weight_loader.sv                    || exit 1
# compile hwpe_sm & axi
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/hwpe_sm_decoder.sv                   || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/hwpe_sm_encoder.sv                   || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/hwpe_sm_address.sv                   || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/hwpe_sm_controller.sv                || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/hwpe_sm_regfile.sv                   || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/hwpe_sm_slave.sv                     || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/hwpe_sm_wrapper.sv                   || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/axi/hwpe_axi_fifo.sv                 || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/axi/hwpe_axi_fifo_earlystall.sv      || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/axi/hwpe_axi_addressgen.sv           || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/axi/hwpe_axi_source.sv               || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/axi/hwpe_axi_sink.sv                 || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/$HWPE_SM_DIR/axi/hwpe_axi_wrapper.sv              || exit 1
# compile wrapper and top						          
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_wrapper.sv                     || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_wrapper_fsm.sv                     || exit 1
vlog -quiet -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_wrapper_slave.sv                     || exit 1
vlog -quiet +define+$1 -sv -work hwce_lib  ${INCDIRS} +nowarnSVCHK ${IPS_PATH}/hwpe/hwce/rtl/hwce_top.sv                         || exit 1

echo "${Cyan}--> HWCE LIB compilation complete! ${NC}"
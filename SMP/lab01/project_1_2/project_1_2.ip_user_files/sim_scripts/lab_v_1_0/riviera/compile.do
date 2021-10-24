vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/lab_v_1_0/ip/lab_v_1_0_core_logic_0_0/sim/lab_v_1_0_core_logic_0_0.v" \
"../../../bd/lab_v_1_0/ip/lab_v_1_0_graphic_controller_0_0/sim/lab_v_1_0_graphic_controller_0_0.v" \
"../../../bd/lab_v_1_0/sim/lab_v_1_0.v" \


vlog -work xil_defaultlib \
"glbl.v"


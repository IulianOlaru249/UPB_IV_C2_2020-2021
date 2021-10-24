vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../bd/lab_v_1_0/ip/lab_v_1_0_core_logic_0_0/sim/lab_v_1_0_core_logic_0_0.v" \
"../../../bd/lab_v_1_0/ip/lab_v_1_0_graphic_controller_0_0/sim/lab_v_1_0_graphic_controller_0_0.v" \
"../../../bd/lab_v_1_0/sim/lab_v_1_0.v" \


vlog -work xil_defaultlib \
"glbl.v"


vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../bd/design_1/ip/design_1_PIC16F873_0_0/sim/design_1_PIC16F873_0_0.v" \
"../../../bd/design_1/ip/design_1_T74LS04_0_0/sim/design_1_T74LS04_0_0.v" \
"../../../bd/design_1/ip/design_1_T74LS373_0_0/sim/design_1_T74LS373_0_0.v" \
"../../../bd/design_1/ip/design_1_m62256_0_0/sim/design_1_m62256_0_0.v" \
"../../../bd/design_1/ip/design_1_m62256_1_0/sim/design_1_m62256_1_0.v" \
"../../../bd/design_1/ip/design_1_chip_select_0_0/sim/design_1_chip_select_0_0.v" \
"../../../bd/design_1/ip/design_1_splitter3_0_0/sim/design_1_splitter3_0_0.v" \
"../../../bd/design_1/ip/design_1_splitter_1_0_0/sim/design_1_splitter_1_0_0.v" \
"../../../bd/design_1/ip/design_1_splitter_2_0_0/sim/design_1_splitter_2_0_0.v" \
"../../../bd/design_1/sim/design_1.v" \


vlog -work xil_defaultlib \
"glbl.v"


vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu \
"../../../bd/design_1/ip/design_1_MC68230_0_0/sim/design_1_MC68230_0_0.v" \
"../../../bd/design_1/ip/design_1_REG_0_0/sim/design_1_REG_0_0.v" \
"../../../bd/design_1/ip/design_1_Decadd_0_0/sim/design_1_Decadd_0_0.v" \
"../../../bd/design_1/sim/design_1.v" \
"../../../bd/design_1/ip/design_1_MC68000_0_2/sim/design_1_MC68000_0_2.v" \


vlog -work xil_defaultlib \
"glbl.v"


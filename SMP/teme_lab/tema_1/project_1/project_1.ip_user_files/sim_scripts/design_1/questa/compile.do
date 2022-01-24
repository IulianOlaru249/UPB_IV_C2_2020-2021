vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../bd/design_1/ip/design_1_usb_0_0/sim/design_1_usb_0_0.v" \
"../../../bd/design_1/ip/design_1_ich8_0_1/sim/design_1_ich8_0_1.v" \
"../../../bd/design_1/ip/design_1_ddr_0_1/sim/design_1_ddr_0_1.v" \
"../../../bd/design_1/ip/design_1_gmch_0_1/sim/design_1_gmch_0_1.v" \
"../../../bd/design_1/ip/design_1_processor_0_1/sim/design_1_processor_0_1.v" \
"../../../bd/design_1/sim/design_1.v" \


vlog -work xil_defaultlib \
"glbl.v"


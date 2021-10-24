onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib lab_v_1_0_opt

do {wave.do}

view wave
view structure
view signals

do {lab_v_1_0.udo}

run -all

quit -force

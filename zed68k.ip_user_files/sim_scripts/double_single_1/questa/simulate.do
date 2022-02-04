onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib double_single_opt

do {wave.do}

view wave
view structure
view signals

do {double_single.udo}

run -all

quit -force

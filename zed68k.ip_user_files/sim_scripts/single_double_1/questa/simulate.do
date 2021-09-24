onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib single_double_opt

do {wave.do}

view wave
view structure
view signals

do {single_double.udo}

run -all

quit -force

onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib fp_mult_opt

do {wave.do}

view wave
view structure
view signals

do {fp_mult.udo}

run -all

quit -force

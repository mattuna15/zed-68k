onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib debug_opt

do {wave.do}

view wave
view structure
view signals

do {debug.udo}

run -all

quit -force

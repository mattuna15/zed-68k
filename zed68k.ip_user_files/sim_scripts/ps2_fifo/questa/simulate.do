onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib ps2_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {ps2_fifo.udo}

run -all

quit -force

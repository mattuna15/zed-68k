onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib write_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {write_fifo.udo}

run -all

quit -force

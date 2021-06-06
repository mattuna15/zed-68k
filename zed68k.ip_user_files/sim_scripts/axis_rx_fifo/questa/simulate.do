onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib axis_rx_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {axis_rx_fifo.udo}

run -all

quit -force

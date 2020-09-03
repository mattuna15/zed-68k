onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib serial_rx_opt

do {wave.do}

view wave
view structure
view signals

do {serial_rx.udo}

run -all

quit -force

onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib serial_opt

do {wave.do}

view wave
view structure
view signals

do {serial.udo}

run -all

quit -force

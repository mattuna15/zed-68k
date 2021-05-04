onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib ethernetlite_opt

do {wave.do}

view wave
view structure
view signals

do {ethernetlite.udo}

run -all

quit -force

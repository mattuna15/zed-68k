onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib memory_opt

do {wave.do}

view wave
view structure
view signals

do {memory.udo}

run -all

quit -force

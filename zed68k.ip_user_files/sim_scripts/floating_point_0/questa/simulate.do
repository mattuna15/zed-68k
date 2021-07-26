onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib floating_point_0_opt

do {wave.do}

view wave
view structure
view signals

do {floating_point_0.udo}

run -all

quit -force

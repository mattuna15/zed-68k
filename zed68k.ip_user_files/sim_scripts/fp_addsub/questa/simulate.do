onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib fp_addsub_opt

do {wave.do}

view wave
view structure
view signals

do {fp_addsub.udo}

run -all

quit -force

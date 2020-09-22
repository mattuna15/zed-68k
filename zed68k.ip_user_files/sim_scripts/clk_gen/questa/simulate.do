onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib clk_gen_opt

do {wave.do}

view wave
view structure
view signals

do {clk_gen.udo}

run -all

quit -force

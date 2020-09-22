onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+clk_gen -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.clk_gen xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {clk_gen.udo}

run -all

endsim

quit -force

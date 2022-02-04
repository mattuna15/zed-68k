onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+serial -L xpm -L xil_defaultlib -L fifo_generator_v13_2_5 -L util_vector_logic_v2_0_1 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.serial xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {serial.udo}

run -all

endsim

quit -force

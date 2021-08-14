onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+fpu_design -L xpm -L fifo_generator_v13_2_5 -L xil_defaultlib -L xlconstant_v1_1_7 -L util_vector_logic_v2_0_1 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.fpu_design xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {fpu_design.udo}

run -all

endsim

quit -force

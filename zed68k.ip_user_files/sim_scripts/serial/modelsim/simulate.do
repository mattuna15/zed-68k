onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -L xpm -L xil_defaultlib -L fifo_generator_v13_2_5 -L util_vector_logic_v2_0_1 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.serial xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {serial.udo}

run -all

quit -force

onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+serial_rx -L xpm -L fifo_generator_v13_2_5 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.serial_rx xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {serial_rx.udo}

run -all

endsim

quit -force

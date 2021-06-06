onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+axis_rx_fifo -L xpm -L axis_infrastructure_v1_1_0 -L axis_data_fifo_v2_0_3 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axis_rx_fifo xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {axis_rx_fifo.udo}

run -all

endsim

quit -force

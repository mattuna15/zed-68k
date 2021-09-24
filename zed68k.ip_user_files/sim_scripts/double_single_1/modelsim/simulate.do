onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -L xilinx_vip -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L xbip_pipe_v3_0_6 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_dsp48_addsub_v3_0_6 -L xbip_dsp48_multadd_v3_0_6 -L xbip_bram18k_v3_0_6 -L mult_gen_v12_0_16 -L floating_point_v7_1_10 -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.double_single xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {double_single.udo}

run -all

quit -force

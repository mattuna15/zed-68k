onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+audio_clock229 -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.audio_clock229 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {audio_clock229.udo}

run -all

endsim

quit -force

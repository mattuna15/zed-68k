onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib audio_clock229_opt

do {wave.do}

view wave
view structure
view signals

do {audio_clock229.udo}

run -all

quit -force

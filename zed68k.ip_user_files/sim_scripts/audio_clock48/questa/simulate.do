onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib audio_clock48_opt

do {wave.do}

view wave
view structure
view signals

do {audio_clock48.udo}

run -all

quit -force

onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib v74x138_0_opt

do {wave.do}

view wave
view structure
view signals

do {v74x138_0.udo}

run -all

quit -force

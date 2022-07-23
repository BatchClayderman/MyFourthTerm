vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../v_74x138_ip.srcs/sources_1/ip/v74x138_0/sources_1/new/v74x138.v" \
"../../../../v_74x138_ip.srcs/sources_1/ip/v74x138_0/sim/v74x138_0.v" \


vlog -work xil_defaultlib \
"glbl.v"


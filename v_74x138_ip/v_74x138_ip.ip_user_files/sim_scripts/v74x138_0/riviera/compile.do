vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../v_74x138_ip.srcs/sources_1/ip/v74x138_0/sources_1/new/v74x138.v" \
"../../../../v_74x138_ip.srcs/sources_1/ip/v74x138_0/sim/v74x138_0.v" \


vlog -work xil_defaultlib \
"glbl.v"


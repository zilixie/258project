#This is the simulation for Project m3

vlib work

vlog -timescale 1ns/1ns *.v

vsim m3_top

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {KEY[0]} 1 0, 0 10000, 1 13000
force {KEY[1]} 1 0
force {KEY[2]} 1 0, 0 10, 1 50
force {KEY[3]} 1 0, 0 20000, 1 25000
force {reset_n} 0 0, 1 2

run 300000ns 
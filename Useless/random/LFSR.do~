#This is the simulation for Project m1 datapath

vlib work

vlog -timescale 1ns/1ns LFSR.v

vsim LFSR

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {rst} 1 0, 0 2
force {enable} 0 0, 0 2, 1 4, 0 6, 1 8, 0 10


run 300

#This is the simulation for Project m1 random_int

vlib work

vlog -timescale 1ns/1ns random_int.v

vsim random_int

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {rst} 1 0, 0 2
force {enable} 0 0, 0 2, 10'd1 4, 0 6, 10'd10 8, 0 10


run 300 

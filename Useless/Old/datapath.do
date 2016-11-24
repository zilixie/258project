#This is the simulation for Project m1 datapath

vlib work

vlog -timescale 1ns/1ns test_datapath.v

vsim datapath

log {/*}

add wave {/*}

#test
force {x_in} 0
force {y_in} 0
force {op} 2'b00
force {clk} 0 0, 1 1 -repeat 2
force {enable} 0 0, 1 2, 0 53
force {reset_n} 0 0, 1 2

run 100

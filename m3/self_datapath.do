#This is the simulation for Project m3 self_datapath

vlib work

vlog -timescale 1ns/1ns self_datapath.v

vsim self_datapath

log {/*}

add wave {/*}

#test
force {x_in} 8'd32
force {op_in} 2'd0
force {clk} 0 0, 1 1 -repeat 2
force {reset_n} 0 0, 1 2
force {enable} 0 0, 1 4
force {load} 0 0, 1 2, 0 4

run 100ns
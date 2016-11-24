#This is the simulation for Project m1 datapath

vlib work

vlog -timescale 1ns/1ns enemy_datapath.v

vsim enemy_datapath

log {/*}

add wave {/*}

#test

force {op} 2'b00
force {load_coord} 1'b0
force {clk} 0 0, 1 1 -repeat 2
force {enable} 0 0, 1 2
force {reset_n} 0 0, 1 2
force {visible} 10'b0000000001

run 600ns

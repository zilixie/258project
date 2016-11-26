#This is the simulation for Project m1 random_int

vlib work

vlog -timescale 1ns/1ns random_int.v

vsim random_int

log {/*}

add wave {/*}

#test
force {reset_n} 0 0, 1 2
force {load_x} 0 0, 0 2, 10'd1 4, 0 6, 10'd10 8, 0 10, 10'd10 16, 0 20, 10'd10 24, 0 30


run 100ns

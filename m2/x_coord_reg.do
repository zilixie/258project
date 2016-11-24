#This is the simulation for Project m2 x_coord_reg

vlib work

vlog -timescale 1ns/1ns x_coord_reg.v

vsim x_coord_reg

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {load_x} 10'b0000000000 0, 10'b0000000001 2, 10'b0000000010 4, 10'b0000000000 6
force {rand_int} 4'd0 0, 4'd2 2, 4'd4 4, 4'd4 6
force {reset_n} 0 0, 1 2 


run 10  

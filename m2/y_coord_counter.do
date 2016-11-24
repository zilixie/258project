 #This is the simulation for Project m2 y_coord_counter

vlib work

vlog -timescale 1ns/1ns y_coord_counter.v

vsim y_coord_counter

log {/*}

add wave {/*}

#test
force {c_en} 10'b1111111111 2, 10'b1111111111 4, 10'b1111111111 6, 10'b1111111111 8
force {move_en} 0 0, 1 2
force {des} 10'b0000000000 2, 10'b0000000001 35, 10'b0000000000 37, 10'b0000000010 55, 10'b0000000000 57
force {flying_rate} 2'b00
force {clk} 0 0, 1 1 -repeat 2
force {reset_n} 0 0, 1 2

run 3000

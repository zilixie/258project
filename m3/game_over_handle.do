#This is the simulation for Project m3 game_over_handle

vlib work

vlog -timescale 1ns/1ns game_over_handle.v

vsim game_over_handle

log {/*}

add wave {/*}

#test
force {touch_edge} 10'd0 0, 10'd1 10
force {self_x} 8'd1
force {self_y} 8'd1
force {x0_in} 8'd4
force {x1_in} 8'd4
run 30
#This is the simulation for Project m3 self_control

vlib work

vlog -timescale 1ns/1ns self_control.v

vsim self_control

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {reset_n} 0 0, 1 2
force {KEY[0]} 1 0, 0 50, 1 250
force {KEY[1]} 1 0, 0 254, 1 500
force {KEY[3]} 1 0, 0 504, 1 800
force {self_state} 4'd1 0, 4'd0 900

run 1000
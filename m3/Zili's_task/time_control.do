#This is the simulation for Project m3 time_control

vlib work

vlog -timescale 1ns/1ns time_control.v

vsim time_control

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {enable} 1 0

run 300  

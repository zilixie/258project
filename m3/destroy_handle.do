#This is the simulation for Project m3 destroy_handle

vlib work

vlog -timescale 1ns/1ns destroy_handle.v

vsim destroy_handle

log {/*}

add wave {/*}

#test
force {fire} 0 0, 1 10
force {x0_in} 8'd2
force {self_x} 8'd2
force {x1_in} 8'd12

run 30ns
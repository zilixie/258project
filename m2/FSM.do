 #This is the simulation for Project m2 FSM

vlib work

vlog -timescale 1ns/1ns FSM.v

vsim FSM

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {reset_n} 0 0, 1 2
force {start} 0 0, 1 10, 0 50

run 30000ns
 

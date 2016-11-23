 #This is the simulation for Project m2 amount control

vlib work

vlog -timescale 1ns/1ns amount_control.v

vsim amount_control

log {/*}

add wave {/*}

#test
force {plane_amount} 4'd10 

run 50


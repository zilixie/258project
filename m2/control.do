 #This is the simulation for Project m2 control

vlib work

vlog -timescale 1ns/1ns *.v

vsim control

log {/*}

add wave {/*}

#test
force {plane_amount} 4'b001
force {clk} 0 0, 1 1 -repeat 2
force {flying_rate} 2'b00
force {reset_n} 0 0, 1 2
force {start} 0 0, 1 10, 0 50

run 3000000ns
#This is the simulation for Project m1 datapath

vlib work

vlog -timescale 1ns/1ns *.v

vsim control

log {/*}

add wave {/*}

#test
force {clk} 0 0, 1 1 -repeat 2
force {reset_n} 0 0, 1 2
force {button[0]} 1 0, 0 20, 1 40, 0 60

run 300

#This is the simulation for Project m1 datapath

vlib work

vlog -timescale 1ns/1ns LFSR.v

vsim LFSR

log {/*}

add wave {/*}

#test
force {clock} 0 0, 1 1 -repeat 2
force {reset} 1 0, 0 2

run 3000

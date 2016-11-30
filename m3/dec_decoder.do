#This is the simulation for Project m3 dec_decoder

vlib work

vlog -timescale 1ns/1ns dec_decoder.v

vsim dec_decoder

log {/*}

add wave {/*}

#test
force {des} 10'b0000000000 0, 10'b0000000001 2 -repeat 2
force {reset_n} 0 0, 1 2

run 300 

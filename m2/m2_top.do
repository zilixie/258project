#This is the simulation for Project m2

vlib work

vlog -timescale 1ns/1ns *.v

vsim m2

log {/*}

add wave {/*}

#test
force {SW} 4'b0001 0, 4'b0010 1300000
force {CLOCK_50} 0 0, 1 1 -repeat 2
force {resetn} 0 0, 1 2
force {KEY[1]} 0 0, 1 10, 0 50

run 26000000

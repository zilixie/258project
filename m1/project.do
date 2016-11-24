#This is the simulation for Project m1 project

vlib work

vlog -timescale 1ns/1ns project.v

vsim project

log {/*}

add wave {/*}

#test
force {CLOCK_50} 0 0, 1 1 -repeat 2
force {KEY[3]} 0 0, 1 2
force {KEY[0]} 1 0, 0 54, 1 55

run 300

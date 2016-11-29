#This is the simulation for Project m3 datapath_mux

vlib work

vlog -timescale 1ns/1ns datapath_mux.v

vsim datapath_mux

log {/*}

add wave {/*}

#test
force {x_self} 8'd42 0, 8'd0 10 , 8'd82 20, 8'd0 30
force {y_self} 7'd110 0
force {x_enemy} 8'd42 0
force {y_enemy} 8'd0 0, 8'd10 10, 8'd20 20, 8'd30 30
force {color_self} 3'b000 0
force {color_enemy} 3'b111 0
force {datapath_select} 0 0, 1 20

run 300 

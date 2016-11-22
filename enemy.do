#This is the simulation for Project m1 datapath

vlib work

vlog -timescale 1ns/1ns m2_datapath.v

vsim enemy_datapath

log {/*}

add wave {/*}

#test
force {x0_in} 8'd12 
force {x1_in} 8'd32 
force {x2_in} 8'd0
force {x3_in} 8'd0 
force {x4_in} 8'd0 
force {x5_in} 8'd0 
force {x6_in} 8'd0 
force {x7_in} 8'd0 
force {x8_in} 8'd0 
force {x9_in} 8'd0 
force {y0_in} 8'd0 
force {y1_in} 8'd0 
force {y2_in} 8'd0 
force {y3_in} 8'd0 
force {y4_in} 8'd0 
force {y5_in} 8'd0 
force {y6_in} 8'd0 
force {y7_in} 8'd0 
force {y8_in} 8'd0 
force {y9_in} 8'd0
force {op} 2'b00
force {load_coord} 1'b1
force {clk} 0 0, 1 1 -repeat 2
force {enable} 0 0, 1 2
force {reset_n} 0 0, 1 2
force {visible} 10'b0000000001

run 100

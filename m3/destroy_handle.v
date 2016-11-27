module destroy_handle
	(
	input fire,
	input [7:0] self_x, self_y
	input [7:0] x0_in, x1_in, x2_in, x3_in, x4_in, x5_in, x6_in, x7_in, x8_in, x9_in, 
				y0_in, y1_in, y2_in, y3_in, y4_in, y5_in, y6_in, y7_in, y8_in, y9_in,
	output [9:0] des, load_x
	);
	
	/* Once a plane is destroyed, send des signal to Y coord counter and
	send load_x signal to x register to load the next random coord. */
	
	
endmodule

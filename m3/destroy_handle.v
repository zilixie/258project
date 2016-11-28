module destroy_handle
	(
	input fire,
	input [7:0] self_x,
	input [7:0] x0_in, x1_in, x2_in, x3_in, x4_in, x5_in, x6_in, x7_in, x8_in, x9_in, 
	output [9:0] des
	);
	
	/* Once a plane is destroyed, send des signal to Y coord counter and
	send the signal to x register to load the next random coord. */
	
	
endmodule

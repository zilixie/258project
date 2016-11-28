module destroy_handle
	(
	input fire,
	input [7:0] self_x,
	input [7:0] x0_in, x1_in, x2_in, x3_in, x4_in, x5_in, x6_in, x7_in, x8_in, x9_in, 
	output [9:0] des
	);
	
	/* Once a plane is destroyed, send des signal to Y coord counter and
	send the signal to x register to load the next random coord. */
	
	assign des[0] = (self_x == x0_in & fire) ? 1'b1 : 1'b0;
	assign des[1] = (self_x == x1_in & fire) ? 1'b1 : 1'b0;
	assign des[2] = (self_x == x2_in & fire) ? 1'b1 : 1'b0;
	assign des[3] = (self_x == x3_in & fire) ? 1'b1 : 1'b0;
	assign des[4] = (self_x == x4_in & fire) ? 1'b1 : 1'b0;
	assign des[5] = (self_x == x5_in & fire) ? 1'b1 : 1'b0;
	assign des[6] = (self_x == x6_in & fire) ? 1'b1 : 1'b0;
	assign des[7] = (self_x == x7_in & fire) ? 1'b1 : 1'b0;
	assign des[8] = (self_x == x8_in & fire) ? 1'b1 : 1'b0;
	assign des[9] = (self_x == x9_in & fire) ? 1'b1 : 1'b0;
	
	
endmodule

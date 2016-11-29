module game_over_handle
	(
	input [9:0] touch_edge,
	input [7:0] self_x, self_y,
	input [7:0] x0_in, x1_in, x2_in, x3_in, x4_in, x5_in, x6_in, x7_in, x8_in, x9_in, 
				y0_in, y1_in, y2_in, y3_in, y4_in, y5_in, y6_in, y7_in, y8_in, y9_in,
	output game_is_over
	);
	
	wire [9:0] crash = 10'd0;
	
	assign game_is_over = (touch_edge != 10'd0 | crash != 10'd0) ? 1'b1 : 1'b0;
	
	wire [31:0] dis0;
	//assign dis0 = (self_x - x0_in)*(self_x - x0_in) + (self_y - y0_in)^(self_y - y0_in);
	assign dis0 = self_x * x0_in;
	// assign crash[0] = ()
	
	
	
endmodule
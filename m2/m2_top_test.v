module m2
	(
	input [9:0]SW,
	input CLOCK_50
	);	
	
	// Wires
	
	wire [7:0]  x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, 
					y0, y1, y2, y3, y4, y5, y6, y7, y8, y9;
	wire [9:0] vis;
	wire [1:0] op;
	wire load_coord, enable_datapath;
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	
	// Control
	control c0 
		(
			.plane_amount(SW[3:0]),
			.clk(CLOCK_50), 
			.reset_n(resetn),
			.flying_rate(SW[5:4]),
			.x0(x0), 
			.x1(x1), 
			.x2(x2), 
			.x3(x3), 
			.x4(x4), 
			.x5(x5), 
			.x6(x6), 
			.x7(x7), 
			.x8(x8), 
			.x9(x9), 
			.y0(y0), 
			.y1(y1), 
			.y2(y2), 
			.y3(y3), 
			.y4(y4), 
			.y5(y5), 
			.y6(y6), 
			.y7(y7), 
			.y8(y8),
			.y9(y9),
			.vis(vis),
			.op(op),
			.load_coord(load_coord), 
			.enable_datapath(enable_datapath), 
			.plot(writeEn)
		);
		
	// Datapath
	enemy_datapath e0 
		(
			.x0_in(x0), 
			.x1_in(x1), 
			.x2_in(x2), 
			.x3_in(x3), 
			.x4_in(x4), 
			.x5_in(x5), 
			.x6_in(x6), 
			.x7_in(x7), 
			.x8_in(x8), 
			.x9_in(x9), 
			.y0_in(y0), 
			.y1_in(y1), 
			.y2_in(y2), 
			.y3_in(y3), 
			.y4_in(y4), 
			.y5_in(y5), 
			.y6_in(y6), 
			.y7_in(y7), 
			.y8_in(y8), 
			.y9_in(y9),
			.load_coord(load_coord), 
			.clk(CLOCK_50), 
			.enable(enable_datapath),
			.op(op),
			.visible(vis),
			.reset_n(resetn),
			.x_out(x), 
			.y_out(y),
			.color_out(colour)
		);
endmodule

module m2_top
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		  KEY,
		  SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
		
		
	// Wires
	
	wire [7:0]  x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, 
					y0, y1, y2, y3, y4, y5, y6, y7, y8, y9;
	wire [9:0] vis;
	wire [1:0] op;
	wire load_coord, enable_datapath;
	
	// Control
	control c0 
		(
			.plane_amount(SW[3:0]),
			.clk(CLOCK_50), 
			.reset_n(resetn),
			.flying_rate(SW[5:4]),
			.start(~KEY[1]),
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

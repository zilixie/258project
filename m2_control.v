module enemy_control(
							input [3:0] plane_amount, 
							input clk, reset_n, move_en
							input [1:0] flying_rate,
							output reg [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, 
												  y0, y1, y2, y3, y4, y5, y6, y7, y8, y9,
							output reg [2:0] vis0, vis1, vis2, vis3, vis4, vis5, vis6, vis7, vis8, vis9,
							output reg [1:0] op
							output reg datapath_en, load_coord
							);

	localparam 
					black = 3'b000,
					white = 3'b111,
					
	// Handle numbers of enemy's plane.
	// ...
	
	// X Coord handle.
	wire [7:0] rand_int;
	wire next_int;
	
	random_int r0 (.next_int(next_int),
						.rand_int(rand_int)
						);
						
	
		
endmodule




module control(
				input [3:0] plane_amount,
				input clk, reset_n,
				input [1:0] flying_rate,
				output [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, 
							 y0, y1, y2, y3, y4, y5, y6, y7, y8, y9,
				output [9:0] vis,
				output [1:0] op,
				output load_coord, enable_datapath, plot
				);

	wire [9:0] load_x, c_en, touch_edge, des;
	wire [3:0] rand_int;
	wire move_en;
	
	
	random_int r0 (
					.enable(load_x),
					.out(rand_int),
					.clk(clk),
					.reset_n(reset_n)
					);
	
	amount_control a0(
						.plane_amount(plane_amount),
						.c_en(c_en),
						.vis(vis)
						);
						
	destroy_handle d0(
						.touch_edge(touch_edge),
						.load_x(load_x),
						.des(des)
						);
						
	FSM f0(
			.clk(clk),
			.reset_n(reset_n),
			.move_en(move_en),
			.load_coord(load_coord),
			.datapath_en(enable_datapath),
			.op(op),
			.plot(plot)
			);
			
	x_coord_reg xcrd0(
						.load_x(load_x),
						.rand_int(rand_int),
						.x0(x0),
						.x1(x1),
						.x2(x2),
						.x3(x3),
						.x4(x4),
						.x5(x5),
						.x6(x6),
						.x7(x7),
						.x8(x8),
						.x9(x9)
						);
						
	y_coord_counter ycrd0(
							.c_en(c_en),
							.move_en(move_en),
							.des(des),
							.flying_rate(flying_rate),
							.reset_n(reset_n),
							.clk(clk),
							.touch_edge(touch_edge),
							.y0(y0),
							.y1(y1),
							.y2(y2),
							.y3(y3),
							.y4(y4),
							.y5(y5),
							.y6(y6),
							.y7(y7),
							.y8(y8),
							.y9(y9)
							);

				
				
endmodule
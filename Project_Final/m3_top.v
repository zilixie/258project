module m3_top
	(
	input [3:0] KEY,
	input clk,
	input reset_n,
	output [7:0] mux_x_out, mux_y_out,
	output [2:0] mux_color_out,
	output plot,
	output [6:0] HEX0, HEX1, HEX2, HEX3
	);
	
	wire [9:0] touch_edge, vis, des;
	wire [1:0] enemy_op, self_op, flying_rate;
	wire [2:0] enemy_color_out;
	wire [3:0] self_state, plane_amount, next_int;
	wire move_en, load_coord, enemy_datapath_en, fsm_reset_n, en_time_control, datapath_select, self_en, fire_enable;
	wire [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, enemy_x_out, enemy_y_out;
	
	
	wire [7:0] self_x_out, self_y_out, self_x;
	wire [2:0] color_self;
	
	FSM f0
	(
	.clk(clk),
	.reset_n(reset_n), 
	.start(~KEY[2]), 
	.touch_edge(touch_edge),
	.move_en(move_en), 
	.load_coord(load_coord), 
	.enemy_datapath_en(enemy_datapath_en), 
	.plot(plot), 
	.reset_n_out(fsm_reset_n), 
	.en_time_control(en_time_control),
	.enemy_op(enemy_op),
	.self_state(self_state),
	.datapath_select(datapath_select)
	);
	
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
	.clk(clk),
	.enable(enemy_datapath_en),
	.op(enemy_op),
    .visible(vis),
    .reset_n(fsm_reset_n),
	.x_out(enemy_x_out), 
	.y_out(enemy_y_out),
    .color_out(enemy_color_out)
	);
	
	datapath_mux m0
	(
	.x_self(self_x_out), 
	.y_self(self_y_out),
	.x_enemy(enemy_x_out), 
	.y_enemy(enemy_y_out),
	.color_self(color_self), 
	.color_enemy(enemy_color_out),
	.datapath_select(datapath_select),
	.x(mux_x_out), 
	.y(mux_y_out),
	.color(mux_color_out)
	);
	
	self_datapath s0
	(
	.x_in(self_x),
	.op_in(self_op),
	.clk(clk), 
	.reset_n(fsm_reset_n), 
	.enable(self_en), 
	.load(load_coord),
	.x_out(self_x_out), 
	.y_out(self_y_out),
	.color_out(color_self)
	);
	
	self_control c0
	(
	.clk(clk), 
	.reset_n(fsm_reset_n),
    .KEY(KEY),
	.self_state(self_state),
    .op(self_op),
    .x(self_x),
    .self_enable(self_en),
	.enable_fire(fire_enable)
	);
	
	destroy_handle h0
	(
	.fire(fire_enable),
	.self_x(self_x),
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
	.des(des)
	);
	
	dec_decoder d0
	(
	.des(des), 
    .reset_n(fsm_reset_n),
	.HEX0(HEX0), 
	.HEX1(HEX1), 
	.HEX2(HEX2), 
	.HEX3(HEX3)
	);
	
	y_coord_counter c1
	(
	.c_en(vis),
	.move_en(move_en),
	.des(des),
	.flying_rate(flying_rate),
	.reset_n(fsm_reset_n), 
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
	
	time_control t0
	(
	.enable(en_time_control), 
	.clk(clk),
	.plane_amount(plane_amount),
	.flying_rate(flying_rate)
	);
	
	random_int r0
	(
	.out(next_int), 
	.load_x(des), 
	.reset_n(fsm_reset_n)
	);
	
	x_coord_reg r1
	(
	.load_x(des),
	.rand_int(next_int),
	.reset_n(fsm_reset_n), 
	.clk(clk),
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
	
	amount_control a0
	(
	.plane_amount(plane_amount),
	.vis(vis)
	);
	
endmodule
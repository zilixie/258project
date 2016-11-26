module datapath_mux
	(
	input [7:0] x_self, y_self, x_enemy, y_enemy,
	input [2:0] color_self, color_enemy,
	input datapath_select,
	output [7:0] x, y,
	output [2:0] color
	);
	// Select signal from self_datapath or enemy_datapath according 
	// to datapath_select signal.
	
endmodule
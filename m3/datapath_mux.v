module datapath_mux
	(
	input [7:0] x_self, y_self, x_enemy, y_enemy,
	input [2:0] color_self, color_enemy,
	input datapath_select,
	output reg [7:0] x, y,
	output reg [2:0] color
	);
	// Select signal from self_datapath or enemy_datapath according 
	// to datapath_select signal.

        //0: self_datapath
        //1: enemy_datapath

	always@(*)
		begin
		case(datapath_select)
        	1'b0: 
			begin
			x = x_self;
			y = y_self;
			color = color_self;
			end
			1'b1: 
			begin
			x = x_enemy;
			y = y_enemy;
			color = color_enemy;
			end
		endcase
		end
endmodule


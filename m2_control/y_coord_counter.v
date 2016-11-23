// Y coord handle

module y_coord_counter(
							  input [9:0] c_en,
							  input move_en, // the signal that enable move counter.
							  input [9:0] des,
							  input [1:0] flying_rate,
							  input reset_n, clk,
							  output [9:0] touch_edge,
							  output [7:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9
							  );

	wire move;
	
		  
	// Move counter
	// Generate "move" signal at some speed if move_en is high. If "move" signal is high,
	// Y coord will " + 1 " at posedge of clk.
	
	reg [23:0] counter_value;
	
	always @(*)
	begin
		case(flying_rate)
			2'b00: counter_value = 24'd10;//12499999
			2'b01: counter_value = 24'd6499999;
			2'b10: counter_value = 24'd3999999;
			2'b11: counter_value = 24'd1999999;
		endcase
	end
	
	reg [23:0]m;
	
	always @(posedge clk)
	begin
		if (!reset_n)
			m <= counter_value;
		else if (move_en)
		begin
			if (m == 24'd0)
				m <= counter_value;
			else
				m <= m - 1'b1;
		end
	end
	
	assign move = (m == 24'd0) ? 1 : 0;
	
	// Y counter.
	y_counter c0(.enable(c_en[0]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[0]),
				         .y_out(y0),
					 .touch_edge(touch_edge[0])
					 );
					 
	y_counter c1(.enable(c_en[1]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[1]),
				         .y_out(y1),
					 .touch_edge(touch_edge[1])
					 );
	
	y_counter c2(.enable(c_en[2]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[2]),
				         .y_out(y2),
					 .touch_edge(touch_edge[2])
					 );
					 
	y_counter c3(.enable(c_en[3]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[3]),
				         .y_out(y3),
					 .touch_edge(touch_edge[3])
					 );
					 
	y_counter c4(.enable(c_en[4]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[4]),
				         .y_out(y4),
					 .touch_edge(touch_edge[4])
					 );
					 
	y_counter c5(.enable(c_en[5]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[5]),
				         .y_out(y5),
					 .touch_edge(touch_edge[5])
					 );
					
	y_counter c6(.enable(c_en[6]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[6]),
				         .y_out(y6),
					 .touch_edge(touch_edge[6])
					 );
					 
	y_counter c7(.enable(c_en[7]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[7]),
				         .y_out(y7),
					 .touch_edge(touch_edge[7])
					 );
					 
	y_counter c8(.enable(c_en[8]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[8]),
				         .y_out(y8),
					 .touch_edge(touch_edge[8])
					 );
					 
	y_counter c9(.enable(c_en[9]), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(des[9]),
				         .y_out(y9),
					 .touch_edge(touch_edge[9])
					 );

					 
endmodule

// y_counter module. Keep track of enemy's plane's y coord.
module y_counter(
					  input enable, clk, move, reset_n, destroyed,
					  output reg [7:0] y_out,
					  output touch_edge
					  );
	
	always @(posedge clk, destroyed)
	begin
		if (!reset_n)
			y_out <= 8'd0;
		else if (enable & move)
			begin
			if (y_out == 8'd120)
				y_out <= 8'd0;
			else
				y_out = y_out + 1'b1;
			end
		else if (destroyed)
			y_out <= 8'd0;
	end

	assign touch_edge = (y_out == 8'd120) ? 1'b1 : 1'b0;
	
endmodule

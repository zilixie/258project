module enemy_control(
							input [3:0] plane_amount, 
							input clk, reset_n, move_en
							input [1:0] flying_rate,
							output reg [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, 
												  y0, y1, y2, y3, y4, y5, y6, y7, y8, y9,
							output reg [2:0] vis0, vis1, vis2, vis3, vis4, vis5, vis6, vis7, vis8, vis9
							);

	localparam 
					black = 3'b000,
					white = 3'b111,
					S_DRAW = 3'b000,
					S_ERASE = 3'b001,
	
	reg c0en, c1en, c2en, c3en, c4en, c5en, c6en, c7en, c8en, c9en;
	wire move, p9_edge, p8_edge, p7_edge, p6_edge, p5_edge, p4_edge, p3_edge, p2_edge, p1_edge, p0_edge;

	always @(*)
	begin
		c0en = 1'b0;
		c1en = 1'b0;
		c2en = 1'b0;
		c3en = 1'b0;
		c4en = 1'b0;
		c5en = 1'b0;
		c60en = 1'b0;
		c7en = 1'b0;
		c8en = 1'b0;
		c9en = 1'b0;
		vis0 = black;
		vis1 = black;
		vis2 = black;
		vis3 = black;
		vis4 = black;
		vis5 = black;
		vis6 = black;
		vis7 = black;
		vis8 = black;
		vis9 = black;
		
		case (plane_amount)
			4'd1: begin
				c0en = 1'b1;
				vis0 = white;
				end
			4'd2:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				end
			4'd3:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				end
			4'd4:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				c3en = 1'b1;
				vis3 = white;
				end
			4'd5:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				c3en = 1'b1;
				vis3 = white;
				c4en = 1'b1;
				vis4 = white;
				end
			4'd6:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				c3en = 1'b1;
				vis3 = white;
				c4en = 1'b1;
				vis4 = white;
				c5en = 1'b1;
				vis5 = white;
				end
			4'd7:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				c3en = 1'b1;
				vis3 = white;
				c4en = 1'b1;
				vis4 = white;
				c5en = 1'b1;
				vis5 = white;
				c6en = 1'b1;
				vis6 = white;
				end
			4'd8:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				c3en = 1'b1;
				vis3 = white;
				c4en = 1'b1;
				vis4 = white;
				c5en = 1'b1;
				vis5 = white;
				c6en = 1'b1;
				vis6 = white;
				c7en = 1'b1;
				vis7 = white;
				end
			4'd9:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				c3en = 1'b1;
				vis3 = white;
				c4en = 1'b1;
				vis4 = white;
				c5en = 1'b1;
				vis5 = white;
				c6en = 1'b1;
				vis6 = white;
				c7en = 1'b1;
				vis7 = white;
				c8en = 1'b1;
				vis8 = white;
				end
			4'd10:begin
				c0en = 1'b1;
				vis0 = white;
				c1en = 1'b1;
				vis1 = white;
				c2en = 1'b1;
				vis2 = white;
				c3en = 1'b1;
				vis3 = white;
				c4en = 1'b1;
				vis4 = white;
				c5en = 1'b1;
				vis5 = white;
				c6en = 1'b1;
				vis6 = white;
				c7en = 1'b1;
				vis7 = white;
				c8en = 1'b1;
				vis8 = white;
				c9en = 1'b1;
				vis9 = white;
				end
			endcase
	end
	
	// Y Coord handle.
	y_counter c0(.enable(c0en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p0des),
					 .flying_rate(flying_rate),
				    .y_out(y0),
					 .touch_edge(p0_edge)
					 );
					 
	y_counter c1(.enable(c1en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p1des),
					 .flying_rate(flying_rate),
				    .y_out(y1),
					 .touch_edge(p1_edge)
					 );
	
	y_counter c2(.enable(c2en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p2des),
					 .flying_rate(flying_rate),
				    .y_out(y2),
					 .touch_edge(p2_edge)
					 );
					 
	y_counter c3(.enable(c3en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p3des),
					 .flying_rate(flying_rate),
				    .y_out(y3),
					 .touch_edge(p3_edge)
					 );
					 
	y_counter c4(.enable(c4en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p4des),
					 .flying_rate(flying_rate),
				    .y_out(y4),
					 .touch_edge(p4_edge)
					 );
					 
	y_counter c5(.enable(c5en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p5des),
					 .flying_rate(flying_rate),
				    .y_out(y5),
					 .touch_edge(p5_edge)
					 );
					
	y_counter c6(.enable(c6en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p6des),
					 .flying_rate(flying_rate),
				    .y_out(y6),
					 .touch_edge(p6_edge)
					 );
					 
	y_counter c7(.enable(c7en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p7des),
					 .flying_rate(flying_rate),
				    .y_out(y7),
					 .touch_edge(p7_edge)
					 );
					 
	y_counter c8(.enable(c8en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p8des),
					 .flying_rate(flying_rate),
				    .y_out(y8),
					 .touch_edge(p8_edge)
					 );
					 
	y_counter c9(.enable(c9en), 
					 .clk(clk), 
					 .move(move), 
					 .reset_n(reset_n), 
					 .destroyed(p9des),
					 .flying_rate(flying_rate),
				    .y_out(y9),
					 .touch_edge(p9_edge)
					 );
					 
	// Boarder touch detection.
	wire [9:0]touch_edge_sum;
	wire touch_edge;
	assign touch_edge = ({p9_edge, p8_edge, p7_edge, p6_edge, p5_edge, p4_edge, p3_edge, p2_edge, p1_edge, p0_edge} == 10'd0) ? 1'b0 : 1'b1;
	
	// Wait counter.
	/* Generate "go" signal. "go" signal should be generate after 
	   "en_wait_counter" is high for 1/30s. */
	reg [20:0] w;
	
	always @(posedge clk)
	begin
		if (!reset_n)
			w <= 21'd0;
		else if (en_wait_counter)
		begin
			if (w == 21'd1666666)
				w <= 21'd0;
			else
				w = w + 1'b1;
		end
	end
	
	assign go = (w == 21'd1666666) ? 1'b1 : 1'b0;
	
	// End
	
	// FSM.
	// State table
	always @(*)
	begin
		case (current_state)
			S_DRAW: next_state = done == 1'b1 ? S_ERASE : S_DRAW;
			S_ERASE: next_state = done ? S_CHECK_OVER : S_ERASE;
			S_CHECK_OVER: next_state = touch_edge ? S_GAME_OVER : S_WAIT;
			S_GAME_OVER: next_state = S_DRAW;
			S_WAIT: next_state = go ? S_DRAW : S_WAIT;
		endcase
	end
	
	
	always @(*)
	begin
		
		case
			S_DRAW: // Not yet complete
			S_ERASE:
			S_CHECK_OVER:
			S_GAME_OVER:
			S_WAIT:
		endcase
	end
	
	// State register
	always @(posedge clk)
	begin
		if(!reset_n)
			current_state <= S_DRAW;
		else
			current_state <= next_state;
	end
	
	
	// Move counter
	// Generate "move" signal every 1/4s if move_en is high. If "move" signal is high,
	// Y coord will update at posedge of clk.
	reg [23:0]m;
	
	always @(posedge clk)
	begin
		if (!reset_n)
			m <= 24'd0;
		else if (move_en)
		begin
			if (m == 24'd12499999)
				m <= 24'd0;
			else
				m <= m + 1'b1;
		end
	end
	
	assign move = (m == 24'd12499999) ? 1 : 0;
		
endmodule

// y_counter module. Keep track of enemy's plane's y coord.
module y_counter(
					input enable, clk, move, reset_n, destroyed
					input [1:0]flying_rate,
					output reg [7:0] y_out,
					output touch_edge
					);
					
	wire touch_edge;
	
	always @(posedge clk, destroyed)
	begin
		if (!reset_n)
			y_out <= 8'd0;
		else if (enable & move)
			begin
			if (y_out == 8'd120)
				y_out <= 8'd0;
			else
				y_out = y_out + flying_rate;
			end
		else if (destroyed)
			y_out <= 8'd0;
	end

	assign touch_edge = (y_out == 8'd120) ? 1'b1 : 1'b0;
	
endmodule

// Generate a new random int (4'd0-4'd15) when "next_int" goes high.
module random_int(
						input next_int, // Additional input may required.
						output [3:0] rand_int
						);
						
endmodule

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
					S_DRAW = 3'b000,
					S_ERASE = 3'b001,
					S_WAIT = 3'b010;
	
	

	
	// Handle numbers of enemy's plane.
	reg c0en, c1en, c2en, c3en, c4en, c5en, c6en, c7en, c8en, c9en;
	
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
	
	// X Coord handle.
	wire [7:0] rand_int;
	wire next_int;
	
	random_int r0 (.next_int(next_int),
						.rand_int(rand_int)
						);
						
	//X Coord registers.
	
	wire load_x0, load_x1, load_x2, load_x3, load_x4, 
		  load_x5, load_x6, load_x7, load_x8, load_x9;
	
	always @(*)
	begin
		if (load_x0)
			x0 = 10 * rand_int + 3;
		else if (load_x1)
			x1 = 10 * rand_int + 3;
		else if (load_x2)
			x2 = 10 * rand_int + 3;
		else if (load_x3)
			x3 = 10 * rand_int + 3;
		else if (load_x4)
			x4 = 10 * rand_int + 3;
		else if (load_x5)
			x5 = 10 * rand_int + 3;
		else if (load_x6)
			x6 = 10 * rand_int + 3;
		else if (load_x7)
			x7 = 10 * rand_int + 3;
		else if (load_x8)
			x8 = 10 * rand_int + 3;
		else if (load_x9)
			x9 = 10 * rand_int + 3;
		else
			x0 = 8'd102;
			x1 = 8'd82; 
			x2 = 8'd62; 
			x3 = 8'd122; 
			x4 = 8'd72; 
			x5 = 8'd32; 
			x6 = 8'd42; 
			x7 = 8'd2; 
			x8 = 8'd12; 
			x9 = 8'd142;
	end
	
	// Destroy handle.

	wire p0des, p1des, p2des, p3des, p4des, 
		  p5des, p6des, p7des, p8des, p9des; // = 1'b0 ?
		  
	wire p9_edge, p8_edge, p7_edge, p6_edge, p5_edge, 
		  p4_edge, p3_edge, p2_edge, p1_edge, p0_edge;
	
	// Temprary assign destroy.
	assign p0des = p0_edge;
	assign p1des = p1_edge;
	assign p2des = p2_edge;
	assign p3des = p3_edge;
	assign p4des = p4_edge;
	assign p5des = p5_edge;
	assign p6des = p6_edge;
	assign p7des = p7_edge;
	assign p8des = p8_edge;
	assign p9des = p9_edge;
	
	// Assign load signal.
	assign load_x0 = (p0des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x1 = (p1des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x2 = (p2des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x3 = (p3des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x4 = (p4des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x5 = (p5des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x6 = (p6des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x7 = (p7des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x8 = (p8des == 1'b1) ? 1'b1 : 1'b0;
	assign load_x9 = (p9des == 1'b1) ? 1'b1 : 1'b0;
	
	assign next_int = p0des|p1des|p2des|p3des|p4des|p5des|p6des|p7des|p8des|p9des;
	
	
	
	// Y Coord handle.
	wire move;
	
		  
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
			if (m == 24'd12499999) // real rate: 24'd12499999
				m <= 24'd0;
			else
				m <= m + 1'b1;
		end
	end
	
	assign move = (m == 24'd12499999) ? 1 : 0; // real rate: 24'd12499999
	
	// Y counter.
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
	wire [9:0] touch_edge_sum = {p9_edge, p8_edge, p7_edge, p6_edge, p5_edge, 
										  p4_edge, p3_edge, p2_edge, p1_edge, p0_edge};
	wire touch_edge;
	assign touch_edge = ( touch_edge_sum == 10'd0) ? 1'b0 : 1'b1;
	// End
	
	
	// FSM.
	// State table
	always @(*)
	begin
		case (current_state)
			S_DRAW: next_state = done ? S_ERASE : S_DRAW;
			S_ERASE: next_state = done ? S_WAIT : S_ERASE;
			// S_CHECK_OVER: next_state = touch_edge ? S_GAME_OVER : S_WAIT;
			// S_GAME_OVER: next_state = S_DRAW;
			S_WAIT: next_state = go ? S_DRAW : S_WAIT;
		endcase
	end
	
	
	always @(*)
	begin
		move_en = 1'b0;
		en_wait_counter = 1'b0;
		op = 2'b00;
		load_coord = 1'b0;
		datapath_en = 1'b0;
		case
			S_DRAW: begin
				move_en = 1'b1;
				op = 2'b00;
				end
			S_ERASE: begin
				op = 2'b01;
				end
				
			/*S_CHECK_OVER: begin
			
			end
			S_GAME_OVER: begin
			
			end*/
			
			S_WAIT: begin
				move_en = 1'b1;
				end
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
			if (w == 21'd1666666) // real: 21'd1666666
				w <= 21'd0;
			else
				w = w + 1'b1;
		end
	end
	
	assign go = (w == 21'd1666666) ? 1'b1 : 1'b0; // real: 21'd1666666
	
	// End
		
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

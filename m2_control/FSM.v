module FSM(
			  input clk, reset_n,
			  output move_en, load_coord, datapath_en,
			  output [1:0] op
			  );
				
	localparam  S_DRAW  = 4'd0,
					S_ERASE = 4'd1,
					S_WAIT  = 4'd2,
					S_CHECK_OVER = 4'd3,
					S_GAME_OVER = 4'd4
					;
					
	wire touch_edge = 1'b0 // Due to m2's design, touch_edge will always be low. Game will never over.
	
	// State table
	always @(*)
	begin
		case (current_state)
			S_DRAW: next_state = done ? S_ERASE : S_DRAW;
			S_ERASE: next_state = done ? S_WAIT : S_ERASE;
		   S_CHECK_OVER: next_state = touch_edge ? S_GAME_OVER : S_WAIT;
			S_GAME_OVER: next_state = S_DRAW;
			S_WAIT: next_state = go ? S_LOAD_COORD : S_WAIT;
			S_LOAD_COORD: next_state = S_DRAW;
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
				datapath_en = 1'b1;
				end
			S_ERASE: begin
				move_en = 1'b1;
				op = 2'b01;
				datapath_en = 1'b1;
				end
			S_CHECK_OVER: begin
			
				end
			S_GAME_OVER: begin
			
				end
			S_WAIT: begin
				move_en = 1'b1;
				en_wait_counter = 1'b1;
				end
			S_LOAD_COORD: begin
				load_coord = 1'b1;
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
	
	// Done counter.
	// ...
	
endmodule

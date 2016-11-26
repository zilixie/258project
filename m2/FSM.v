module FSM(
			  input clk, reset_n, start,
			  output reg move_en, load_coord, datapath_en, plot, reset_n_out,
			  output reg [1:0] op
			  );
				
	localparam  S_START  = 4'd0,
					S_START_WAIT = 4'd7,
					S_RESET = 4'd8,
					S_ERASE = 4'd1,
					S_WAIT  = 4'd2,
					S_CHECK_OVER = 4'd3,
					S_GAME_OVER = 4'd4,
					S_DRAW = 4'd5,
					S_LOAD_COORD = 4'd6;
	// Wires
	wire touch_edge = 1'b0; // Due to m2's design, touch_edge will always be low. Game will never over.
	
	reg done_en, en_wait_counter;
	wire done, go;
	
	// State table
	
	reg [4:0] current_state, next_state;
	
	always @(*)
	begin
		case (current_state)
			S_START: next_state = start ? S_START_WAIT : S_START;
			S_START_WAIT: next_state = start ? S_START_WAIT : S_RESET;
			S_RESET: next_state = S_LOAD_COORD;
			S_DRAW: next_state = done ? S_CHECK_OVER : S_DRAW;
		   S_CHECK_OVER: next_state = touch_edge ? S_GAME_OVER : S_WAIT;
			S_GAME_OVER: next_state = S_DRAW;
			S_WAIT: next_state = go ? S_ERASE : S_WAIT;
			S_ERASE: next_state = done ? S_LOAD_COORD : S_ERASE;
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
		done_en = 1'b0;
		plot = 1'b0;
		reset_n_out = 1'b1;
		case(current_state)
			S_RESET: begin
				reset_n_out = 1'b0;
				end
			S_DRAW: begin
				move_en = 1'b1;
				op = 2'b00;
				datapath_en = 1'b1;
				done_en = 1'b1;
				plot = 1'b1;
				end
			S_ERASE: begin
				move_en = 1'b1;
				op = 2'b01;
				datapath_en = 1'b1;
				done_en = 1'b1;
				plot = 1'b1;
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
			default: begin
				move_en = 1'b0;
				en_wait_counter = 1'b0;
				op = 2'b00;
				load_coord = 1'b0;
				datapath_en = 1'b0;
				done_en = 1'b0;
				plot = 1'b0;
				reset_n_out = 1'b1;
				end
		endcase
	end
	
	// State register
	always @(posedge clk)
	begin
		if(!reset_n)
			current_state <= S_START;
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
	
	reg [7:0] done_c;
	
	always @(posedge clk)
	begin
		if (!reset_n)
			done_c <= 8'd0;
		else if (done_en)
		begin
			if (done_c == 8'd249) // real: 249
				done_c <= 8'd0;
			else
				done_c <= done_c + 1'b1;
		end
	end
	
	assign done = (done_c == 8'd249) ? 1'b1 : 1'b0; // real: 249
	
endmodule

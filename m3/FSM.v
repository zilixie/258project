module FSM
	(
	input clk, reset_n, start, 
	input [9:0] touch_edge,
	output reg move_en, load_coord, enemy_datapath_en, plot, reset_n_out, en_time_control,
	output reg [1:0] enemy_op,
	output reg [3:0] self_state,
	output reg datapath_select
	);
				
	localparam  
		S_START      = 4'd0,
		S_START_WAIT = 4'd1,
		S_RESET      = 4'd2,
		S_LOAD_COORD = 4'd3,
		S_SELF_DRAW  = 4'd4,
		S_ENEMY_DRAW = 4'd5,
		S_CHECK_OVER = 4'd6,
		S_WAIT       = 4'd7,
		S_SLEF_ERASE = 4'd8,
		S_ENEMY_ERASE = 4'd9,
		S_GAME_OVER  = 4'd10;
		
	// Wires
	
	reg self_done_en, enemy_done_en, en_wait_counter;
	wire self_done, enemy_done, go;
	
	// State table
	
	reg [4:0] current_state, next_state;
	
	always @(*)
	begin
		case (current_state)
			// Start process.
			S_START: next_state = start ? S_START_WAIT : S_START;
			S_START_WAIT: next_state = start ? S_START_WAIT : S_RESET;
			S_RESET: next_state = S_LOAD_COORD;
			
			// Loop.
			// Load Coord to datapath.
			S_LOAD_COORD: next_state = S_SELF_DRAW;
			// Draw
			S_SELF_DRAW: next_state = self_done ? S_ENEMY_DRAW : S_SELF_DRAW;
			S_ENEMY_DRAW: next_state = enemy_done ? S_CHECK_OVER : S_ENEMY_DRAW;
			// Check game over.
			S_CHECK_OVER: next_state = (touch_edge == 10'd0) ? S_WAIT : S_GAME_OVER;
			// Wait 0.25 sec.
			S_WAIT: next_state = go ? S_SLEF_ERASE : S_WAIT;
			// Erase
			S_SLEF_ERASE: next_state = self_done ? S_ENEMY_ERASE : S_SLEF_ERASE;
			S_ENEMY_ERASE: next_state = enemy_done ? S_LOAD_COORD : S_ENEMY_ERASE;
			
			
			// Game over.
			S_GAME_OVER: next_state = S_GAME_OVER;
		endcase
	end
	
	
	always @(*)
	begin
		move_en           = 1'b0;
		en_wait_counter   = 1'b0;
		enemy_op          = 2'b00;
		load_coord        = 1'b0;
		enemy_datapath_en = 1'b0;
		self_done_en      = 1'b0;
		enemy_done_en     = 1'b0;
		plot              = 1'b0;
		reset_n_out       = 1'b1;
		self_state        = 1'b0;
		datapath_select   = 1'b0;
		en_time_control   = 1'b0;
		
		case(current_state)
			S_RESET: reset_n_out = 1'b0;
			
			S_LOAD_COORD: load_coord = 1'b1;
			
			S_SELF_DRAW: begin
				move_en = 1'b1;
				self_state = 4'd1;
				self_done_en = 1'b1;
				plot = 1'b1;
				datapath_select = 1'b0;
				en_time_control = 1'b1;
				end
				
			S_ENEMY_DRAW: begin
				move_en = 1'b1;
				enemy_op = 2'b00;
				enemy_datapath_en = 1'b1;
				enemy_done_en = 1'b1;
				plot = 1'b1;
				datapath_select   = 1'b1;
				en_time_control = 1'b1;
				end
				
			S_WAIT: begin
				move_en = 1'b1;
				en_wait_counter   = 1'b1;
				en_time_control = 1'b1;
				end
			
			S_SLEF_ERASE: begin
				move_en = 1'b1;
				self_done_en = 1'b1;
				self_state = 4'd2;
				plot = 1'b1;
				datapath_select   = 1'b0;
				en_time_control = 1'b1;
				end
				
			S_ENEMY_ERASE: begin
				move_en = 1'b1;
				enemy_op = 2'b01;
				enemy_datapath_en = 1'b1;
				enemy_done_en = 1'b1;
				plot = 1'b1;
				datapath_select   = 1'b1;
				en_time_control = 1'b1;
				end
			
			default: begin
			
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
	
	// Self done counter, generate self_done signal.
	
	reg [4:0] self_draw_count;
	
	always @(posedge clk)
	begin
	if (reset_n == 1'b0)
		self_draw_count <= 5'd0;
	else if (self_done_en == 1'b1)
		begin
		if (self_draw_count == 5'd24)
			self_draw_count <= 5'd0;
		else
			self_draw_count = self_draw_count + 1'b1;
		end
	end
   
	assign self_done = (self_draw_count == 5'd24) ? 1'b1 : 1'b0;
	
	// Wait counter.
	/* Generate "go" signal. "go" signal should be generate after 
	   "en_wait_counter" is high for 1/30s. */
	reg [20:0] wait_count;
	
	always @(posedge clk)
	begin
		if (!reset_n)
			wait_count <= 21'd0;
		else if (en_wait_counter)
		begin
			if (wait_count == 21'd4000) // real: 21'd1666666
				wait_count <= 21'd0;
			else
				wait_count = wait_count + 1'b1;
		end
	end
	
	assign go = (wait_count == 21'd4000) ? 1'b1 : 1'b0; // real: 21'd1666666
	
	// End
	
	// Done counter.
	
	reg [7:0] enemy_done_count;
	
	always @(posedge clk)
	begin
		if (!reset_n)
			enemy_done_count <= 8'd0;
		else if (enemy_done_en)
		begin
			if (enemy_done_count == 8'd249) // real: 249
				enemy_done_count <= 8'd0;
			else
				enemy_done_count <= enemy_done_count + 1'b1;
		end
	end
	
	assign enemy_done = (enemy_done_count == 8'd249) ? 1'b1 : 1'b0; // real: 249
	
endmodule

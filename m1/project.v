module project
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
      KEY,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input		CLOCK_50;				//	50 MHz
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	 

	wire reset_n;
	assign reset_n = 1'b0;
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [7:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(reset_n),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.


	wire [1:0]op;
	wire counter_enable, load;
   wire [7:0] x_pos;


	datapath d0(
					.x_in(x_pos),
					.y_in(8'd110),
               .op_in(op),
					.clk(CLOCK_50),
					.reset_n(reset_n),
					.enable(counter_enable),
					.x_out(x),
					.y_out(y),
					.color_out(colour),
					.load(load)
					);

   // Instansiate FSM control
	control c0(
				.clk(CLOCK_50),
				.button(KEY[3:0]),
				.reset_n(reset_n),
				.plot(writeEn),
				.op(op),
            .x(x_pos),
            .counter_enable(counter_enable),
				.load(load)
				);



endmodule


module control(
        input clk, reset_n,
        input [2:0] button,
        output reg [1:0] op,
        output reg [7:0] x = 8'd80,
        output reg plot, counter_enable, load
		  );

	reg [1:0] current_state, next_state;
	reg enable_fire = 1'b0;
   	reg [4:0] draw_count, erase_count;
   	reg [20:0] wait_count;
	reg [24:0] fire_count;
   	reg enable_draw, enable_wait;

   	wire done, wait_go, stop_fire;
   	localparam DRAW   = 2'b00,
              	   ERASE  = 2'b01,
              	   WAIT   = 2'b10,
		   S_LOAD = 2'b11;
				  
	
	// State table
	always @(*)
        begin
	case (current_state)
		S_LOAD: next_state = DRAW;
		DRAW: next_state = done ? WAIT : DRAW;
		WAIT: next_state = wait_go ? ERASE : WAIT;
		ERASE: next_state = done ? S_LOAD : ERASE;
		default: next_state = S_LOAD;
        endcase
	end

	always @(*)
	begin
		plot = 1'b0;
		counter_enable = 1'b0;
		enable_draw = 1'b0;
		enable_wait = 1'b0;
		op = 2'b00;
		load = 1'b0;
		case (current_state)
		
		S_LOAD:
		begin
			load = 1'b1; // Load x, y to datapath.
		end
		DRAW: 
		begin
         		if (enable_fire == 1'b0)
         		begin
		      		plot = 1'b1;
				counter_enable = 1'b1;
		      		op = 2'b00;
		      		enable_draw = 1'b1;
				enable_wait = 1'b0;
         		end
         		else if (enable_fire == 1'b1) // If enable_fire, then set op to 2.
         		begin
		     		plot = 1'b1;
				counter_enable = 1'b1;
		  	    	op = 2'b10;
		     		enable_draw = 1'b1;
				enable_wait = 1'b0;
           		end
		end
		WAIT:
			begin
			plot = 1'b1;
			counter_enable = 1'b0;
			enable_draw = 1'b0;
			enable_wait = 1'b1;
			end
		ERASE:
			begin
		        plot = 1'b1;
		        counter_enable = 1'b1;
             		op = 2'b01;
            	 	enable_draw = 1'b1;
			enable_wait = 1'b0;
			end
      		default:
			begin
			plot = 1'b1;
			counter_enable = 1'b0;
			enable_draw = 1'b0;
			enable_wait = 1'b0;
			op = 2'b00;
			end
		endcase
		
	end

	// Draw counter, generate done signal.
   always @(posedge clk)
	begin
	if (reset_n == 1'b0)
		draw_count <= 5'd0;
	else if (enable_draw == 1'b1)
		begin
		if (draw_count == 5'd25)
			draw_count <= 5'd0;
		else
			draw_count = draw_count + 1'b1;
		end
	end
   
	assign done = (draw_count == 5'd25) ? 1'b1 : 1'b0;

	// Go counter, generate go signal
   always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			wait_count <= 21'b0;
	   else if (enable_wait == 1'b1)
			begin
			if (wait_count == 21'd1666666)
				wait_count <= 21'b0;
			else
				wait_count = wait_count + 1'b1;
			end
	end
   
	assign wait_go = (wait_count == 21'd1666666) ? 1'b1 : 1'b0;
	
	// State register.
	always @(posedge clk)
	begin
	if(!reset_n)
		current_state <= S_LOAD;
	else
		current_state <= next_state;
	end

	//  Left and right button counter, only react press every 0.1 second.
	reg [28:0] read_btn_c;
	wire read_btn_en;
		
	always @(posedge clk)
	begin
	if (!reset_n)
		read_btn_c <= 28'd0;
	else
		begin
		if (read_btn_c == 28'd0)
			read_btn_c <= 28'd5000000;
		else
			read_btn_c <= read_btn_c - 1'b1;
		end
	end
	
	assign read_btn_en = (read_btn_c == 28'd0) ? 1'b1 : 1'b0;
	
	// X position register.
   always @(posedge clk)
   begin
   if(!reset_n)
		x <= 8'd80;
	else if (~button[0] & read_btn_en)
		x <= x + 1'b1;
	else if (~button[1] & read_btn_en)
		x <= x - 1'b1;
	end
	
	// Fire button counter, only react fire button 1 time a second.
	reg [28:0] read_fire_c;
	wire read_fire_en;
		
	always @(posedge clk)
	begin
	if (!reset_n)
		read_fire_c <= 28'd0;
	else
		begin
		if (read_fire_c == 28'd0)
			read_fire_c <= 28'd5000000;
		else
			read_fire_c <= read_fire_c - 1'b1;
		end
	end
	
	assign read_fire_en = (read_fire_c == 28'd0) ? 1'b1 : 1'b0;
	
	// Fire register.
   always @(posedge clk)
   begin
   if(!reset_n)
		enable_fire <= 1'b0;
	else if (~button[2] & read_fire_en)
		enable_fire <= 1'b1;
	else if (stop_fire == 1'b1)
	   enable_fire <= 1'b0;
	end
	
	// Every fire remain for 0.25 sec.
	always @(posedge clk)
	begin
	if (reset_n == 1'b0)
      fire_count <= 25'd0;
	else if (enable_fire == 1'b1)
		begin
		if (fire_count == 25'd1249999)
			fire_count <= 25'd0;
		else
			fire_count = fire_count + 1'b1;
		end
	end
	
	assign stop_fire = (fire_count == 25'd1249999) ? 1'b1 : 1'b0;

endmodule


// Datapath

module datapath(
					input [7:0] x_in, y_in,
					input [1:0] op_in,
					input clk, reset_n, enable, load,
					output [7:0] x_out, y_out,
					output reg [2:0] color_out
					);
					
	reg [2:0] x_count, y_count;
	wire en_y_count;
	reg [7:0] x, y;
	//reg [1:0] op;
	
	localparam  draw       = 2'b00,
		    erase      = 2'b01,
		    fire       = 2'b10,
		    erase_fire = 2'b11,
		    black      = 3'b000,
		    white      = 3'b111,
		    red        = 3'b100;
	
	always @(posedge clk)
	begin
		if (!reset_n)
		begin
			x <= 8'd80;
			y <= 8'd110;
			//op <= 2'd0;
		end
		else if (load == 1'b1)
		begin
			x <= x_in;
			y <= y_in;
			//op <= op_in;
		end
	end
	
	// X counter
	always @(posedge clk)
	begin
	if (reset_n == 1'b0)
		x_count <= 3'b000;
	else if (enable)
		begin
		if (x_count == 3'b100)
			begin
			x_count <= 3'b000;
			//en_y_count <= 1'b1;
			end
		else
			begin
			x_count = x_count + 1'b1;
			//en_y_count <= 1'b0;
			end
		end
	end
	
	assign en_y_count = (x_count == 3'b000) ? 1'b1 : 1'b0;
	
	// Y counter
	always @(posedge clk)
	begin
	if (reset_n == 1'b0)
		y_count <= 3'b000;
	else if (en_y_count & enable)
		begin
		if (y_count == 3'b100)
			y_count <= 3'b000;
		else
			y_count = y_count + 1'b1;
		end
	end
	
	assign x_out = x + x_count;
	assign y_out = y + y_count;
	
	// Color handle
	always @(*)
	begin
	color_out = black;
	case (op_in)
		draw: begin
			if (y_count == 3'b001 & x_count == 3'b010)
				color_out = white;
			else if (y_count == 3'b010)
				color_out = white;
			else if (y_count == 3'b011 & x_count == 3'b010)
				color_out = white;
			else if (y_count == 3'b100)
				begin
				if (x_count == 3'b001)
					color_out = white;
				else if (x_count == 3'b010)
					color_out = white;
				else if (x_count == 3'b011)
					color_out = white;
				end
			end
		
		erase: color_out = black;
		
		fire: begin
			if (y_count == 3'b000 & x_count == 3'b010)
				color_out = red;
			else if (y_count == 3'b001 & x_count == 3'b010)
				color_out = white;
			else if (y_count == 3'b010)
				color_out = white;
			else if (y_count == 3'b011 & x_count == 3'b010)
				color_out = white;
			else if (y_count == 3'b100)
				begin
				if (x_count == 3'b001)
					color_out = white;
				else if (x_count == 3'b010)
					color_out = white;
				else if (x_count == 3'b011)
					color_out = white;
				end
			end
			
			default: color_out = black;
			
	endcase
	end
	
endmodule

	

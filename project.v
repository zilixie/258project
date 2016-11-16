module project
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
                KEY,
	);

	input		CLOCK_50;				//	50 MHz
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	 

	wire reset_n;
	assign reset_n = KEY[3];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [7:0] y;
	wire writeEn;


	wire [1:0]option;
	wire counter_enable;
        wire [7:0] x_pos;


	datapath d0(
					.x_in(x_pos),
					.y_in(8'd60),
                                        .op(option),
					.clk(CLOCK_50),
					.reset_n(reset_n),
					.enable(counter_enable),
					.x_out(x),
					.y_out(y),
					.color_out(colour)
					);

    // Instansiate FSM control
	control c0(
				.clk(CLOCK_50),
				.button(KEY[3:0]),
				.reset_n(reset_n),
				.plot(writeEn),
				.op(option),
                                .x(x_pos),
                                .counter_enable(counter_enable)
				);



endmodule


module control(clk, button, reset_n, op, x, counter_enable, plot);
        input clk, reset_n;
        input [3:0] button;
        output reg [1:0] op;
        output reg [7:0] x = 8'd80;
        output reg plot, counter_enable;

	reg [1:0] current_state, next_state;
        reg [4:0] draw_count, erase_count;
        reg [20:0] wait_count;
        reg enable_draw, enable_wait, enable_erase;

        wire draw_done, erase_done, wait_go;
        localparam DRAW  = 2'b00,
                   ERASE = 2'b01,
                   WAIT  = 2'b10;

        always @(*)
        begin

		case (current_state)
		DRAW: next_state = draw_done ? WAIT : DRAW;
		WAIT: next_state = wait_go ? ERASE : WAIT;
		ERASE: next_state = erase_done ? DRAW : ERASE;
		default: next_state = DRAW;
                endcase
        end

	always @(*)
	begin
		plot = 1'b0;
		counter_enable = 1'b0;
		enable_draw = 1'b0;
		enable_wait = 1'b0;
                enable_erase = 1'b0;
		case (current_state)
			DRAW: 
				begin
		                        plot = 1'b1;
		                        counter_enable = 1'b1;
                                        op = 2'b00;
                                        enable_draw = 1'b1;
					enable_wait = 1'b0;
                                        enable_erase = 1'b0;
				end
			WAIT:
				begin
		                        plot = 1'b1;
		                        counter_enable = 1'b0;
                                        enable_draw = 1'b0;
					enable_wait = 1'b1;
                                        enable_erase = 1'b0;
				end
			ERASE:
				begin
		                        plot = 1'b1;
		                        counter_enable = 1'b1;
                                        op = 2'b01;
                                        enable_draw = 1'b0;
					enable_wait = 1'b0;
                                        enable_erase = 1'b1;
				end
                        default:
				begin
		                plot = 1'b1;
		                counter_enable = 1'b0;
				enable_draw = 1'b0;
				enable_wait = 1'b0;
				enable_erase = 1'b0;
				end
		endcase
		
	end

        always @(posedge clk)
	begin
		if (reset_n == 1'b0)
                	draw_count <= 5'b00000;
	   	else if (enable_draw == 1'b1)
			begin
			if (draw_count == 5'b11000)
                                begin
				draw_count <= 5'b00000;
                                end
			else
				draw_count = draw_count + 1'b1;
			end
	end
        assign draw_done = (draw_count == 5'b11000) ? 1'b1 : 1'b0;


        always @(posedge clk)
	begin
		if (reset_n == 1'b0)
                	wait_count <= 21'b0;
	   	else if (enable_wait == 1'b1)
			begin
			if (wait_count == 21'd25)
                                begin
				wait_count <= 21'b0;
                                end
			else
				wait_count = wait_count + 1'b1;
			end
	end
        assign wait_go = (wait_count == 21'd25) ? 1'b1 : 1'b0;


        always @(posedge clk)
	begin
	if (reset_n == 1'b0)
                erase_count <= 5'b00000;
	else if (enable_erase == 1'b1)
		begin
		if (erase_count == 5'b11000)
                        begin
			erase_count <= 5'b00000;
                        end
		else
			erase_count = erase_count + 1'b1;
		end
	end
        assign erase_done = (erase_count == 5'b11000) ? 1'b1 : 1'b0;




	always@(posedge clk)
		begin
			if(!reset_n)
				current_state <= DRAW;
			else
				current_state <= next_state;
		end


        always@(negedge button[0], negedge button[1])
                begin
                        if(!reset_n)
				x <= 8'd0;
			else if (~button[0])
				x <= x + 1'b1;
			else if (~button[1])
				x <= x - 1'b1;
		end

endmodule











module datapath(
					input [7:0] x_in, y_in,
					input [1:0] op,
					input clk, reset_n, enable,
					output [7:0] x_out, y_out,
					output reg [2:0] color_out
					);
					
	reg [2:0] x_count, y_count;
	wire en_y_count;
	
	localparam  draw       = 2'b00,
		    erase      = 2'b01,
		    fire       = 2'b10,
		    erase_fire = 2'b11,
		    black      = 3'b000,
		    white      = 3'b111,
		    red        = 3'b100;
	
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
	
	assign en_y_count = (x_count == 3'b000) ? 1 : 0;
	
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
	
	assign x_out = x_in + x_count;
	assign y_out = y_in + y_count;
	
	// Color handle
	always @(*)
	begin
	color_out = black;
	case (op)
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
			
	endcase
	end
	
endmodule

	

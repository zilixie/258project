module datapath(
					input [7:0] x_in, y_in,
					input [1:0] op,
					input clk, reset_n, enable,
					output [7:0] x_out, y_out,
					output reg [2:0] color_out
					);
					
	reg [2:0] x_count, y_count;
	reg en_y_count;
	
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
			en_y_count <= 1'b1;
			end
		else
			begin
			x_count = x_count + 1'b1;
			en_y_count <= 1'b0;
			end
		end
	end
	
	// Y counter
	always @(posedge clk)
	begin
	if (reset_n == 1'b0)
		y_count <= 3'b000;
	else if (en_y_count)
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

	

module self_datapath
	(
	input [7:0] x_in,
	input [1:0] op_in,
	input clk, reset_n, enable, load,
	output [7:0] x_out, y_out,
	output reg [2:0] color_out
	);
					
	reg [2:0] x_count, y_count;
	wire en_y_count;
	reg [7:0] x, y;
	
	localparam  draw       = 2'd0,
		    erase      = 2'd1,
		    fire       = 2'd2,

		    black      = 3'b000,
		    white      = 3'b111,
		    red        = 3'b100;
	
	always @(posedge clk)
	begin
		if (!reset_n)
		begin
			x <= 8'd82;
			y <= 8'd110;
		end
		else if (load == 1'b1)
		begin
			x <= x_in;
			y <= 8'd110;
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
			end
		else
			begin
			x_count = x_count + 1'b1;
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
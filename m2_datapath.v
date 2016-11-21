module enemy_datapath(
							input [7:0] x0_in, x1_in, x2_in, x3_in, x4_in, x5_in, x6_in, x7_in, x8_in, x9_in, 
										   y0_in, y1_in, y2_in, y3_in, y4_in, y5_in, y6_in, y7_in, y8_in, y9_in,
							input load_coord, clk, enable,
							input [1:0] op,
							output reg [7:0] x_out, y_out, color_out
							);
							
	reg [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9,
				 y0, y1, y2, y3, y4, y5, y6, y7, y8, y9,
	
	localparam draw = 1'b00,
				  erase = 1'b01;
				 
	// Coord Register
	always @(posedge clk)
	begin
		if (!reset)
		begin
			x0 <= 8'd0;
			x1 <= 8'd0;
			x2 <= 8'd0; 
			x3 <= 8'd0; 
			x4 <= 8'd0; 
			x5 <= 8'd0; 
			x6 <= 8'd0; 
			x7 <= 8'd0; 
			x8 <= 8'd0; 
			x9 <= 8'd0; 
			y0 <= 8'd0; 
			y1 <= 8'd0; 
			y2 <= 8'd0; 
			y3 <= 8'd0; 
			y4 <= 8'd0; 
			y5 <= 8'd0; 
			y6 <= 8'd0; 
			y7 <= 8'd0; 
			y8 <= 8'd0; 
			y9 <= 8'd0;
		end
		else if (load_coord)
		begin
			x0 <= x0_in;
			x1 <= x1_in;
			x2 <= x2_in; 
			x3 <= x3_in; 
			x4 <= x4_in; 
			x5 <= x5_in; 
			x6 <= x6_in; 
			x7 <= x7_in; 
			x8 <= x8_in; 
			x9 <= x9_in; 
			y0 <= y0_in; 
			y1 <= y1_in; 
			y2 <= y2_in; 
			y3 <= y3_in; 
			y4 <= y4_in; 
			y5 <= y5_in; 
			y6 <= y6_in; 
			y7 <= y7_in; 
			y8 <= y8_in; 
			y9 <= y9_in;
		end
	end
	
	// Selecion counter
	
	reg [3:0] select;
	reg [4:0] s_count;
	
	always @(posedge clk)
	begin
		if (!reset_n)
		begin
			select <= 4'd0;
			s_count <= 5'd0;
		end
		else if (enable)
		begin
			if (s_count == 5'd25)
			begin
				if (select == 4'd9)
					select <= 4'd0;
				else
					select <= select + 1'b1;
				
				s_count <= 5'd0;
			else
				s_count <= s_count +1'b1;
		end
		
	end
	
	
	// mux 9 to 1
	
	reg [7:0] x_buff, y_buff
	
	always @(*)
	begin
		case (select)
			1'd0: begin
			x_buff = x0;
			y_buff = y0;
			end
			1'd1:begin
			x_buff = x1;
			y_buff = y1;
			end
			1'd2:begin
			x_buff = x2;
			y_buff = y2;
			end
			1'd3:begin
			x_buff = x3;
			y_buff = y3;
			end
			1'd4:begin
			x_buff = x4;
			y_buff = y4;
			end
			1'd5:begin
			x_buff = x5;
			y_buff = y5;
			end
			1'd6:begin
			x_buff = x6;
			y_buff = y6;
			end
			1'd7:begin
			x_buff = x7;
			y_buff = y7;
			end
			1'd8:begin
			x_buff = x8;
			y_buff = y8;
			end
			1'd9:begin
			x_buff = x9;
			y_buff = y9;
			end
		endcase
	end
	
	wire en_y_count;
	
	// X counter
	always @(posedge clk)
	begin
	if (reset_n == 1'b0)
		x_count <= 3'b000;
	else if (enable)
		begin
		if (x_count == 3'b100)
			x_count <= 3'b000;
		else
			x_count = x_count + 1'b1;
		end
	end
	
	assign en_y_count = (x_count == 1'b000) ? 1 : 0;
	
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
	
	assign x_out = x_buff + x_count;
	assign y_out = y_buff + y_count;
	
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
			
		endcase
	end
	
endmodule

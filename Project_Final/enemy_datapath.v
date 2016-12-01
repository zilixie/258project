module enemy_datapath(
							input [7:0] x0_in, x1_in, x2_in, x3_in, x4_in, x5_in, x6_in, x7_in, x8_in, x9_in, 
										   y0_in, y1_in, y2_in, y3_in, y4_in, y5_in, y6_in, y7_in, y8_in, y9_in,
							input load_coord, clk, enable,
							input [1:0] op,
                     input [9:0] visible,
                     input reset_n,
							output [7:0] x_out, y_out,
                     output reg [2:0] color_out
							);
							
	reg [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9,
				 y0, y1, y2, y3, y4, y5, y6, y7, y8, y9;
   reg [2:0] x_count, y_count;
	
	localparam draw  = 2'b00,
      		  erase = 2'b01,
				  black = 3'b000;

   reg [2:0] white;
				 
	// Coord Register
	always @(posedge clk)
	begin
		if (!reset_n)
		begin
			x0 <= 8'd102;
			x1 <= 8'd82;
			x2 <= 8'd62; 
			x3 <= 8'd122; 
			x4 <= 8'd72; 
			x5 <= 8'd32; 
			x6 <= 8'd42; 
			x7 <= 8'd2; 
			x8 <= 8'd12; 
			x9 <= 8'd142; 
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
			s_count <= 5'd0;
		else if (enable)
		begin
			if (s_count == 5'd24)
				s_count <= 5'd0;
			else
				s_count <= s_count +1'b1;
		end
	end
	
	always @(posedge clk)
	begin
		if (!reset_n)
			select <= 4'd0;
		else if (s_count == 5'd24)
		begin
			if (select == 4'd9)
				select <= 4'd0;
			else
				select <= select + 1'b1;
		end
			
	end
	
	
	// mux 9 to 1
	
	reg [7:0] x_buff, y_buff;
	
	always @(*)
	begin
		case (select)
			4'd0: begin
				x_buff = x0;
				y_buff = y0;
				if (visible[0] == 1'b0)
					white = 3'b000;
				else
					white = 3'b111;
				end
			4'd1: begin
				x_buff = x1;
				y_buff = y1;
				if (visible[1] == 1'b0)
					white = 3'b000;
				else
					white = 3'b111;
				end
			4'd2:begin
			x_buff = x2;
			y_buff = y2;
               if (visible[2] == 1'b0)
                  white = 3'b000;
               else
                  white = 3'b111;
			end
			4'd3:
			begin
			x_buff = x3;
			y_buff = y3;
               if (visible[3] == 1'b0)
                  white = 3'b000;
               else
                  white = 3'b111;
			end
			4'd4:
			begin
			x_buff = x4;
			y_buff = y4; 
               if (visible[4] == 1'b0)
							white = 3'b000;
               else
							white = 3'b111;
			end
			4'd5:
			begin
			x_buff = x5;
			y_buff = y5;

               if (visible[5] == 1'b0)
							white = 3'b000;
               else
							white = 3'b111;
			end
			4'd6:
			begin
			x_buff = x6;
			y_buff = y6; 
               if (visible[6] == 1'b0)
							white = 3'b000;
               else
							white = 3'b111;
			end
			4'd7:
			begin
			x_buff = x7;
			y_buff = y7;
 
               if (visible[7] == 1'b0)
                  white = 3'b000;
               else
                  white = 3'b111;
			end
			4'd8:
			begin
			x_buff = x8;
			y_buff = y8;
               if (visible[8] == 1'b0)
						white = 3'b000;
               else
						white = 3'b111;
			end
			4'd9:
			begin
			x_buff = x9;
			y_buff = y9; 
               if (visible[9] == 1'b0)
						white = 3'b000;
               else
						white = 3'b111;
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
	
	assign en_y_count = (x_count == 1'b000) ? 1'b1 : 1'b0;
	
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
		color_out = 3'b000;
		case (op)
			draw: begin
				if (y_count == 3'b000)
					begin
					if (x_count == 3'b001)
						color_out = white;
					else if (x_count == 3'b011)
						color_out = white;
					end
				else if (y_count == 3'b001)
					begin
					if (x_count == 3'b000)
						color_out = white;
					else if (x_count == 3'b001)
						color_out = white;
					else if (x_count == 3'b011)
						color_out = white;
					else if (x_count == 3'b100)
						color_out = white;
					end
				else if (y_count == 3'b010)
					begin
					if (x_count == 3'b001)
						color_out = white;
					else if (x_count == 3'b010)
						color_out = white;
					else if (x_count == 3'b011)
						color_out = white;
					end
				else if (y_count == 3'b011 & x_count == 3'b010)
					color_out = white;
				end
			
			erase: color_out = 3'b000;
			
		endcase
	end
	
endmodule

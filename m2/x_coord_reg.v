module x_coord_reg(
						 input [9:0] load_x,
						 input [3:0] rand_int,
						 input reset_n, clk,
						 output reg [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9
						 );

					
	always @(posedge clk)
	begin
		if (!reset_n)
			x0 <= 
			x1 <= 
			x2 <= 
			x3 <= 
			x4 <=
			x5 <=
			x6 <= 
			x7
			x8
			x9
			
		else if (load_x[0])
			x0 = 8'd10 * rand_int + 8'd2;
		else if (load_x[1])
			x1 = 8'd10 * rand_int + 8'd2;
		else if (load_x[2])
			x2 = 8'd10 * rand_int + 8'd2;
		else if (load_x[3])
			x3 = 8'd10 * rand_int + 8'd2;
		else if (load_x[4])
			x4 = 8'd10 * rand_int + 8'd2;
		else if (load_x[5])
			x5 = 8'd10 * rand_int + 8'd2;
		else if (load_x[6])
			x6 = 8'd10 * rand_int + 8'd2;
		else if (load_x[7])
			x7 = 8'd10 * rand_int + 8'd2;
		else if (load_x[8])
			x8 = 8'd10 * rand_int + 8'd2;
		else if (load_x[9])
			x9 = 8'd10 * rand_int + 8'd2;
	end
	
endmodule

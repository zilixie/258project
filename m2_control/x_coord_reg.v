module x_coord_reg(
						 input [9:0] load_x,
						 input [3:0] rand_int,
						 output reg [7:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9
						 );

        reg [7:0] xt0 = 8'd102, xt1 = 8'd82, xt2 = 8'd62, xt3 = 8'd122, xt4 = 8'd72, xt5 = 8'd32, xt6 = 8'd42, xt7 = 8'd2, xt8 = 8'd12, xt9 = 8'd142;
					
	always @(*)
	begin
			x0 = xt0;
			x1 = xt1; 
			x2 = xt2; 
			x3 = xt3; 
			x4 = xt4; 
			x5 = xt5; 
			x6 = xt6; 
			x7 = xt7; 
			x8 = xt8; 
			x9 = xt9;
		if (load_x[0])
                        begin
			x0 = 10 * rand_int + 2;
                        xt0 = x0;
end
		else if (load_x[1])
begin
			x1 = 10 * rand_int + 2;
                        xt1 = x1;
end
		else if (load_x[2])
begin
			x2 = 10 * rand_int + 2;
                        xt2 = x2;
end
		else if (load_x[3])
begin
			x3 = 10 * rand_int + 2;
                        xt3 = x3;
end
		else if (load_x[4])
begin
			x4 = 10 * rand_int + 2;
                        xt4 = x4;
end
		else if (load_x[5])
begin
			x5 = 10 * rand_int + 2;
                        xt5 = x5;
end
		else if (load_x[6])
begin
			x6 = 10 * rand_int + 2;
                        xt6 = x6;
end
		else if (load_x[7])
begin
			x7 = 10 * rand_int + 2;
                        xt7 = x7;
end
		else if (load_x[8])
begin
			x8 = 10 * rand_int + 2;
                        xt8 = x8;
end
		else if (load_x[9])
begin
			x9 = 10 * rand_int + 2;
                        xt9 = x9;
end

	end
	
endmodule

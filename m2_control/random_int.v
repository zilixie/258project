// Generate a new random int (4'd0-4'd15) when "next_int" goes high.
module random_int(
						input [9:0] load_x, // Additional input may required.
						output [3:0] rand_int
						);
						
	wire next_int;
	assign next_int = (load_x == 10'd0) ? 1'b1 : 1'b0;
						
endmodule

// Generate a new random int (4'd0-4'd15) when "next_int" goes high.
module random_int
	(
	output reg [3:0] out,
	input [9:0] load_x,
	input reset_n
	);

	wire feedback;
	
	assign enable = 1'b1;
	reg q;
	
	// Enable signal genrator
	always @(*)
	begin
	if (load_x == 10'd0)
		q = 1'b0;
	else
		q = 1'b1;
	
	end
	
	assign feedback = ~(out[3] ^ out[2]);

	always @(posedge q, negedge reset_n)
	begin
	if (!reset_n)
	  out = 4'b0;
	else
	  out = {out[2:0],feedback};
	end
	  
endmodule

// Handle numbers of enemy's plane.

module amount_control
	( 
	input [3:0] plane_amount,
	output reg [9:0] vis
	);
	
	always @(*)
	begin
		vis  = 10'b0000000001;
		case (plane_amount)
			4'd1: vis  = 10'b0000000001;
			4'd2: vis  = 10'b0000000011;
			4'd3: vis  = 10'b0000000111;
			4'd4: vis  = 10'b0000001111;
			4'd5: vis  = 10'b0000011111;
			4'd6: vis  = 10'b0000111111;
			4'd7: vis  = 10'b0001111111;
			4'd8: vis  = 10'b0011111111;
			4'd9: vis  = 10'b0111111111;
			4'd10:vis  = 10'b1111111111;
			default: vis  = 10'b0000000001;
		endcase
	end
	
endmodule

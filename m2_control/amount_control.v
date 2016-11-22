// Handle numbers of enemy's plane.

module amount_control ( 
							  input [3:0] plane_amount,
							  output reg [9:0] c_en, vis
							  );
	
	always @(*)
	begin
		c_en = 10'b0000000000;
		vis  = 10'b0000000000;
		
		case (plane_amount)
			4'd1: begin
				c_en = 10'b0000000001;
				vis  = 10'b0000000001;
				end
			4'd2:begin
				c_en = 10'b0000000011;
				vis  = 10'b0000000011;
				end
			4'd3:begin
				c_en = 10'b0000000111;
				vis  = 10'b0000000111;
				end
			4'd4:begin
				c_en = 10'b0000001111;
				vis  = 10'b0000001111;
				end
			4'd5:begin
				c_en = 10'b0000011111;
				vis  = 10'b0000011111;
				end
			4'd6:begin
				c_en = 10'b0000111111;
				vis  = 10'b0000111111;
				end
			4'd7:begin
				c_en = 10'b0001111111;
				vis  = 10'b0001111111;
				end
			4'd8:begin
				c_en = 10'b0011111111;
				vis  = 10'b0011111111;
				end
			4'd9:begin
				c_en = 10'b0111111111;
				vis  = 10'b0111111111;
				end
			4'd10:begin
				c_en = 10'b1111111111;
				vis  = 10'b1111111111;
				end
			endcase
	end
	
endmodule

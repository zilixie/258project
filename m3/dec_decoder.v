module dec_decoder
	(
	input [9:0] des, 
        input reset_n,
	output [6:0] HEX0, HEX1, HEX2, HEX3
	);
	// Display score in decimal on HEX, every posedge of "des", number
	// increase by 1.

        reg [15:0] des_count = 16'd0;
	reg q;

        hex_decoder H0(
        .hex_digit(des_count[3:0]), 
        .segments(HEX0)
        );
        
        hex_decoder H1(
        .hex_digit(des_count[7:4]), 
        .segments(HEX1)
        );

        hex_decoder H2(
        .hex_digit(des_count[11:8]), 
        .segments(HEX2)
        );

        hex_decoder H3(
        .hex_digit(des_count[15:12]), 
        .segments(HEX3)
        );


 	always @(*) 
 	begin 
 	if (des == 10'd0) 
 		q = 1'b0; 
 	else 
 		q = 1'b1;  	 
 	end 




	always @(posedge q)
	begin
	if (reset_n == 1'b0)
		des_count <= 16'd0;
	else
		begin
                if (des_count[15:12] == 4'b1001 && des_count[11:8] == 4'b1001 && des_count[7:4] == 4'b1001 && des_count[3:0] == 4'b1001)
                        begin
                                des_count[3:0] <= 4'b0000;
				des_count[7:4] <= 4'b0000;
                        	des_count[11:8] <= 4'b0000;
                        	des_count[15:12] <= 4'b0000;
                        end

                else if (des_count[11:8] == 4'b1001 && des_count[7:4] == 4'b1001 && des_count[3:0] == 4'b1001)
                        begin
                                des_count[3:0] <= 4'b0000;
				des_count[7:4] <= 4'b0000;
                        	des_count[11:8] <= 4'b0000;
                        	des_count[15:12] = des_count[15:12] + 4'b0001;
                        end

                else if (des_count[7:4] == 4'b1001 && des_count[3:0] == 4'b1001)
                        begin
                                des_count[3:0] <= 4'b0000;
				des_count[7:4] <= 4'b0000;
                        	des_count[11:8] = des_count[11:8] + 4'b0001;
                        end

                else if (des_count[3:0] == 4'b1001)
                        begin
				des_count[3:0] <= 4'b0000;
                        	des_count[7:4] = des_count[7:4] + 4'b0001;
                        end

		else
			des_count = des_count + 1'b1;
		end
	end
endmodule



module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b1000000;
            4'h1: segments = 7'b1111001;
            4'h2: segments = 7'b0100100;
            4'h3: segments = 7'b0110000;
            4'h4: segments = 7'b0011001;
            4'h5: segments = 7'b0010010;
            4'h6: segments = 7'b0000010;
            4'h7: segments = 7'b1111000;
            4'h8: segments = 7'b0000000;
            4'h9: segments = 7'b0011000;
            4'hA: segments = 7'b0001000;
            4'hB: segments = 7'b0000011;
            4'hC: segments = 7'b1000110;
            4'hD: segments = 7'b0100001;
            4'hE: segments = 7'b0000110;
            4'hF: segments = 7'b0001110;   
            default: segments = 7'h7f;
        endcase
endmodule

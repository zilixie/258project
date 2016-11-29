module time_control
	(
	input enable, clk,
	output reg [3:0] plane_amount,
	output reg [1:0] flying_rate
	);
	// If enable, plane_amount and flying_rate will increase as time pass.
	// plane_amount from 1 to 10, flying_rate from 0 to 3.


        reg [31:0] plane_time_control = 32'd0;
        reg [31:0] flying_rate_time_control = 32'd0;

        reg [3:0] amount = 4'd1;
        reg [1:0] rate = 2'b00;

        //plane_amount increase by 1 every 10 seconds
        //flaying_rate increase by 1 every 10 seconds


        always @(posedge clk)
	begin
		if (enable == 1'b1)
			begin
                        plane_amount = amount;
			if (plane_time_control == 32'd50000)
                                begin
					plane_time_control <= 32'd0;
                                        amount = amount + 1'b1;
                                        if (amount == 4'd11)
						begin
						plane_amount = 4'd10;
						amount = 4'd10;
						end                                      
                                        plane_amount = amount;
                                end
			else
				plane_time_control = plane_time_control + 1'b1;
			end
	end
  

        always @(posedge clk)
	begin
		if (enable == 1'b1)
			begin
                        flying_rate = rate;
			if (flying_rate_time_control == 32'd50000 && rate == 4)
                                begin
					flying_rate_time_control <= 32'd0;
                                        rate = 2'b00;
                                        flying_rate = rate;
                                end

			else if (flying_rate_time_control == 32'd50000)
                                begin
					flying_rate_time_control <= 32'd0;
                                        rate = rate + 1'b1;
                                        flying_rate = rate;
                                end

			else
				flying_rate_time_control = flying_rate_time_control + 1'b1;
			end
	end

	
endmodule

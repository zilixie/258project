module time_control
	(
	input enable, clk,
	output reg [3:0] plane_amount,
	output reg [1:0] flying_rate
	);
	// If enable, plane_amount and flying_rate will increase as time pass.
	// plane_amount from 1 to 10, flying_rate from 0 to 3.


        reg [31:0] plane_time_control = 32'b0;
        reg [31:0] flying_rate_time_control = 32'b0;

        reg [3:0] amount = 4'b0;
        reg [1:0] rate = 2'b0;

        //plane_amount increase by 1 every 10 seconds
        //flaying_rate increase by 1 every 10 seconds


        always @(posedge clk)
	begin
		if (enable == 1'b1)
			begin
                        plane_amount = amount;
			if (plane_time_control == 32'd50)
                                begin
					plane_time_control <= 32'b0;
                                        amount = amount + 1'b1;
                                        plane_amount = amount;
                                end
			else
				plane_time_control = plane_time_control + 1'b1;
			end
	end
   
	//assign increase = (plane_time_control == 32'd500000000) ? 1'b1 : 1'b0;


        always @(posedge clk)
	begin
		if (enable == 1'b1)
			begin
                        flying_rate = rate;
			if (flying_rate_time_control == 32'd50)
                                begin
					flying_rate_time_control <= 32'b0;
                                        rate = rate + 1'b1;
                                        flying_rate = rate;
                                end
			else
				flying_rate_time_control = flying_rate_time_control + 1'b1;
			end
	end
   
	//assign increase = (flying_rate_time_control == 32'd500000000) ? 1'b1 : 1'b0;

	
endmodule

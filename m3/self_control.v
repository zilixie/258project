module self_control(
        input clk, reset_n,
        input [3:0] KEY,
		input [3:0] self_state,
        output reg [1:0] op,
        output reg [7:0] x,
        output reg self_enable,
		output reg enable_fire
		  );

	
	reg [24:0] fire_count;

   	wire stop_fire;
	
	always @(*)
	begin
		self_enable = 1'b0;
		op = 2'b00;
		case (self_state)
		4'd0:begin
		
			end
		4'd1: begin
			if (enable_fire == 1'b0)
				begin
				self_enable = 1'b1;
				op = 2'b00;
				end
			else if (enable_fire == 1'b1) // If enable_fire, then set op to 2.
				begin
				self_enable = 1'b1;
				op = 2'b10;
				end
			end
		4'd2:
			begin
			self_enable = 1'b1;
			op = 2'b01;
			end
      	default:
			begin
			
			end
		endcase
		
	end
	
	//  Left and right button counter, only react press every 0.5 second.
	reg [28:0] read_btn_c;
	wire read_btn_en;
		
	always @(posedge clk)
	begin
	if (!reset_n)
		read_btn_c <= 28'd0;
	else
		begin
		if (read_btn_c == 28'd0)
			read_btn_c <= 28'd100; // real: d24999999
		else
			read_btn_c <= read_btn_c - 1'b1;
		end
	end
	
	assign read_btn_en = (read_btn_c == 28'd0) ? 1'b1 : 1'b0;
	
	// X position register.
   always @(posedge clk)
   begin
   if(!reset_n)
		x <= 8'd82;
	else if (~KEY[0] & read_btn_en)
		x <= x + 8'd10;
	else if (~KEY[1] & read_btn_en)
		x <= x - 8'd10;
	end
	
	// Fire button counter, only react fire button 1 time a second.
	reg [28:0] read_fire_c;
	wire read_fire_en;
		
	always @(posedge clk)
	begin
	if (!reset_n)
		read_fire_c <= 28'd0;
	else
		begin
		if (read_fire_c == 28'd0)
			read_fire_c <= 28'd100; // real: d50000000
		else
			read_fire_c <= read_fire_c - 1'b1;
		end
	end
	
	assign read_fire_en = (read_fire_c == 28'd0) ? 1'b1 : 1'b0;
	
	// Fire register.
   always @(posedge clk)
   begin
   if(!reset_n)
		enable_fire <= 1'b0;
	else if (~KEY[3] & read_fire_en)
		enable_fire <= 1'b1;
	else if (stop_fire == 1'b1)
	   enable_fire <= 1'b0;
	end
	
	// Every fire remain for 0.25 sec.
	always @(posedge clk)
	begin
	if (reset_n == 1'b0)
      fire_count <= 25'd0;
	else if (enable_fire == 1'b1)
		begin
		if (fire_count == 25'd25) // real: d1249999
			fire_count <= 25'd0;
		else
			fire_count = fire_count + 1'b1;
		end
	end
	
	assign stop_fire = (fire_count == 25'd25) ? 1'b1 : 1'b0; // real: d1249999

endmodule
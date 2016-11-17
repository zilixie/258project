module control(clk, KEY, reset_n, op, x);
        input clk, reset_n;
        input [3:0] KEY;
        output reg [1:0] op;
        output reg [7:0] x = 8'd0;

	reg [1:0] current_state, next_state;
        reg [4:0] draw_count, erase_count;
        reg [20:0] wait_count;
        reg enable_draw, enable_wait, enable_erase;

        wire draw_done, erase_done, wait_go;
        localparam DRAW  = 2'b00,
                   ERASE = 2'b01,
                   WAIT  = 2'b10;

        always @(*)
        begin
		case (current_state)
		DRAW: next_state = draw_done ? WAIT : DRAW;
		WAIT: next_state = wait_go ? ERASE : WAIT;
		ERASE: next_state = erase_done ? DRAW : ERASE;
		default: next_state = DRAW;
                endcase
        end

	always @(*)
	begin
		enable_draw = 1'b0;
		enable_wait = 1'b0;
                enable_erase = 1'b0;
		case (current_state)
			DRAW: 
				begin
                                        op = 2'b00;
                                        enable_draw = 1'b1;
					enable_wait = 1'b0;
                                        enable_erase = 1'b0;
				end
			WAIT:
				begin
                                        enable_draw = 1'b0;
					enable_wait = 1'b1;
                                        enable_erase = 1'b0;
				end
			ERASE:
				begin
                                        op = 2'b01;
                                        enable_draw = 1'b0;
					enable_wait = 1'b0;
                                        enable_erase = 1'b1;
				end
                        default:
				begin
				enable_draw = 1'b0;
				enable_wait = 1'b0;
				enable_erase = 1'b0;
				end
		endcase
		
	end

        always @(posedge clk)
	begin
		if (reset_n == 1'b0)
                	draw_count <= 5'b00000;
	   	else if (enable_draw == 1'b1)
			begin
			if (draw_count == 5'b11000)
                                begin
				draw_count <= 5'b00000;
                                end
			else
				draw_count = draw_count + 1'b1;
			end
	end
        assign draw_done = (draw_count == 5'b11000) ? 1'b1 : 1'b0;


        always @(posedge clk)
	begin
		if (reset_n == 1'b0)
                	wait_count <= 21'b0;
	   	else if (enable_wait == 1'b1)
			begin
			if (wait_count == 21'd25)
                                begin
				wait_count <= 21'b0;
                                end
			else
				wait_count = wait_count + 1'b1;
			end
	end
        assign wait_go = (wait_count == 21'd25) ? 1'b1 : 1'b0;


        always @(posedge clk)
	begin
	if (reset_n == 1'b0)
                erase_count <= 5'b00000;
	else if (enable_erase == 1'b1)
		begin
		if (erase_count == 5'b11000)
                        begin
			erase_count <= 5'b00000;
                        end
		else
			erase_count = erase_count + 1'b1;
		end
	end
        assign erase_done = (erase_count == 5'b11000) ? 1'b1 : 1'b0;




	always@(posedge clk)
		begin
			if(!reset_n)
				current_state <= DRAW;
			else
				current_state <= next_state;
		end


        always@(negedge KEY[0], negedge KEY[1])
                begin
                        if(!reset_n)
				x <= 8'd0;
			else if (~KEY[0])
				x <= x + 1'b1;
			else if (~KEY[1])
				x <= x - 1'b1;
		end

endmodule

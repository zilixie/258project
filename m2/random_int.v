// Generate a new random int (4'd0-4'd15) when "next_int" goes high.
module random_int(out, clk, reset_n, enable);

  output reg [3:0] out;
  input [9:0] enable;
  input clk, reset_n;

  wire feedback;

  assign feedback = ~(out[3] ^ out[2]);

always @(posedge clk, posedge reset_n)
  begin
    if (reset_n)
      out = 4'b0;
    else if (enable != 10'd0)
      out = {out[2:0],feedback};
  end
endmodule

module LFSR (out, clk, rst, enable);

  output reg [3:0] out;
  input [9:0] enable;
  input clk, rst;

  wire feedback;

  assign feedback = ~(out[3] ^ out[2]);

always @(posedge clk, posedge rst)
  begin
    if (rst)
      out = 4'b0;
    else if (enable != 10'd0)
      out = {out[2:0],feedback};
  end
endmodule

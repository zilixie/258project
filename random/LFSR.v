module LFSR (out, clk, rst, enable);

  output reg [3:0] out;
  input clk, rst, enable;

  wire feedback;

  assign feedback = ~(out[3] ^ out[2]);

always @(posedge clk, posedge rst)
  begin
    if (rst)
      out = 4'b0;
    else if (enable)
      out = {out[2:0],feedback};
  end
endmodule

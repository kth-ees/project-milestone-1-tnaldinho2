module alu #(
  BW = 16 // bitwidth
  ) (
  input  logic signed [BW-1:0] in_a,
  input  logic signed [BW-1:0] in_b,
  input  logic           [2:0] opcode,
  output logic signed [BW-1:0] out,
  output logic signed    [2:0] flags // {overflow, negative, zero}
  );

  logic overflow, negative, zero;

  always_comb begin : alu
    out = '0;
    overflow = 0;
    case (opcode)
      3'd0 : begin
        out = in_a + in_b;
        overflow = (in_a[BW-1] == in_b[BW-1]) && (out[BW-1] != in_a[BW-1]);
      end
      3'd1 : begin
        out = in_a - in_b;
        overflow = (in_a[BW-1] != in_b[BW-1]) && (out[BW-1] != in_a[BW-1]);
      end
      3'd2 : out = in_a & in_b;
      3'd3 : out = in_a | in_b;
      3'd4 : out = in_a ^ in_b;
      3'd5 : out = in_a + 1;
      3'd6 : out = in_a;
      3'd7 : out = in_b;
      default : begin
        out = '0;
      end
    endcase
  end

  assign negative = (out[BW-1] == 1) ? 1'b1 : 0;
  assign zero = (out == 0) ? 1'b1 : 0;
  assign flags = {overflow, negative, zero};

endmodule
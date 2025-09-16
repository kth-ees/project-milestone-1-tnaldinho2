module alu #(
  BW = 16 // bitwidth
  ) (
  input  logic unsigned [BW-1:0] in_a,
  input  logic unsigned [BW-1:0] in_b,
  input  logic             [3:0] opcode,
  output logic unsigned [BW-1:0] out,
  output logic             [2:0] flags // {overflow, negative, zero}
  );

  // Complete your RTL code here
  always_comb begin
    case (opcode)
      4'b0000: out = in_a + in_b; // ADD
      4'b0001: out = in_a - in_b; // SUB
      4'b0010: out = in_a & in_b; // AND
      4'b0011: out = in_a | in_b; // OR
      4'b0100: out = in_a ^ in_b; // XOR
      4'b0101: out = in_a + 1;       // Increment
      4'b0110: out = in_a;   // Passthrough A
      4'b0111: out = in_b;   // Passthrough B
      default: out = '0;          // NOP or undefined opcode
    endcase
  end

endmodule





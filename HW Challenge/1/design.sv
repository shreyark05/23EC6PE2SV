typedef enum logic [1:0] {
  ADD,
  SUB,
  MUL,
  XOR
} opcode_t;
module alu (
  input  logic [7:0] a,
  input  logic [7:0] b,
  input  opcode_t    op,
  output logic [15:0] y
);

  always_comb begin
    case (op)
      ADD: y = a + b;
      SUB: y = a - b;
      MUL: y = a * b;
      XOR: y = a ^ b;
      default: y = '0;
    endcase
  end

endmodule
package alu_pkg;
    typedef enum bit [1:0] {ADD, SUB, MUL, XOR} opcode_e;
endpackage


import alu_pkg::*;

module alu (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  opcode_e    op,
    output logic [3:0] y
);

    always_comb begin
        y = 4'b0000;

        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            MUL: y = a * b;
            XOR: y = a ^ b;
        endcase
    end

endmodule

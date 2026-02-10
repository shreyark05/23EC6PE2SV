
typedef enum bit [1:0] {ADD, SUB, AND, OR} opcode_e;


module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  opcode_e   op,
    output logic [7:0] y
);

    always_comb begin
        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            AND: y = a & b;
            OR : y = a | b;
        endcase
    end

endmodule
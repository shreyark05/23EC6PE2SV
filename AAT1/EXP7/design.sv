module siso (
    input  logic clk,
    input  logic si,
    output logic so
);

    logic [3:0] q;

    assign so = q[3];

    always_ff @(posedge clk)
        q <= {q[2:0], si};

endmodule

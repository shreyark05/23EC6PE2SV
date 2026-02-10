module counter (
    input  logic clk,
    input  logic rst,
    output logic [3:0] count
);

    always_ff @(posedge clk)
        if (rst)
            count <= 0;
        else
            count <= count + 1;

endmodule


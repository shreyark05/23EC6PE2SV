
module dff (
    input  logic clk,
    input  logic rst,
    input  logic d,
    output logic q
);

    always_ff @(posedge clk or posedge rst)
        if (rst)
            q <= 0;
        else
            q <= d;

endmodule
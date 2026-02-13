module tb;

    bit clk = 0;
    always #5 clk = ~clk;

    bit rst;
    bit in;
    wire out;

    fsm_101 dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );

    covergroup cg_fsm @(posedge clk);
        cp_state : coverpoint dut.state;
    endgroup

    cg_fsm cg = new();

    initial begin
        rst = 1;
        in  = 0;
        repeat (2) @(posedge clk);
        rst = 0;

        in = 1; repeat (3) @(posedge clk);
        in = 0; repeat (2) @(posedge clk);
        in = 1; repeat (4) @(posedge clk);

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule

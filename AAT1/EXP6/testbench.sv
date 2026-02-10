module tb;

    logic clk = 0;
    logic rst;
    logic [3:0] count;

    counter dut (.*);

    always #5 clk = ~clk;

    covergroup cg_count @(posedge clk);
        option.per_instance = 1;

        cp_val : coverpoint count {
            bins zero = {0};
            bins max  = {15};
            bins roll = (15 => 0);
        }
    endgroup

    cg_count cg = new();

    initial begin
        rst = 1;
        #20;
        rst = 0;

        repeat (40) @(posedge clk);

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule

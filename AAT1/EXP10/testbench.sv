module tb;

    bit clk = 0;
    always #5 clk = ~clk;

    bit rst;
    light_t color;

    traffic dut (
        .clk(clk),
        .rst(rst),
        .color(color)
    );

    covergroup cg_light @(posedge clk);
        cp_c : coverpoint color {
            bins cycle = (RED => GREEN => YELLOW => RED);
        }
    endgroup

    cg_light cg = new();

    initial begin
        rst = 1;
        repeat (2) @(posedge clk);
        rst = 0;
        repeat (10) @(posedge clk);
        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule

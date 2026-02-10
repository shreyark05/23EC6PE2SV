class packet;
    rand bit d, rst;
    constraint c1 { rst dist {0 := 90, 1 := 10}; }
endclass


module tb;

    logic clk = 0;
    logic rst, d, q;

    dff dut (.*);

    always #5 clk = ~clk;

    covergroup cg @(posedge clk);
        cross rst, d;
    endgroup

    cg c_inst = new();
    packet pkt = new();

    initial begin
        repeat (100) begin
            pkt.randomize();
            rst <= pkt.rst;
            d   <= pkt.d;
            @(posedge clk);
        end

        $display("Coverage: %0.2f %%", c_inst.get_inst_coverage());
        $finish;
    end

endmodule
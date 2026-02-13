module tb;

    bit clk = 0;
    always #5 clk = ~clk;

    bit rst;
    bit [3:0] req;
    wire [3:0] gnt;

    arbiter dut (
        .clk(clk),
        .rst(rst),
        .req(req),
        .gnt(gnt)
    );

    assert property (@(posedge clk) $onehot0(gnt))
        else $error("Protocol Violation: Multiple Grants!");

    initial begin
        rst = 1;
        req = 0;
        repeat (2) @(posedge clk);
        rst = 0;

        req = 4'b0001; @(posedge clk);
        req = 4'b0010; @(posedge clk);
        req = 4'b0100; @(posedge clk);
        req = 4'b1000; @(posedge clk);
        req = 4'b0000; @(posedge clk);

        $finish;
    end

endmodule

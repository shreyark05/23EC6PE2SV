module tb;

    logic clk = 0;
    logic si;
    logic so;

    logic [3:0] q_ref = 0;

    siso dut (.*);

    always #5 clk = ~clk;

    initial begin
        repeat (20) begin
            si = $urandom_range(0,1);
            q_ref = {q_ref[2:0], si};
            @(posedge clk);
            #1;
        end
        $finish;
    end

endmodule
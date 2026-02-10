
module tb;

    logic a, b, y;

    and_gate dut (.*);

    covergroup cg_and;
        cp_a : coverpoint a;
        cp_b : coverpoint b;
        cross_ab : cross cp_a, cp_b;
    endgroup

    cg_and cg = new();

    initial begin
        repeat (20) begin
            a = $urandom_range(0,1);
            b = $urandom_range(0,1);
            #5;
            cg.sample();
        end

        $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
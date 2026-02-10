
module tb;

    logic [7:0] a, b, y;
    opcode_e op;

    alu dut (.*);

    covergroup cg_alu;
        cp_op : coverpoint op;
    endgroup

    cg_alu cg = new();

    initial begin
        repeat (50) begin
            a  = $urandom();
            b  = $urandom();
            op = opcode_e'($urandom_range(0,3));
            #5;
            cg.sample();
        end

        $display("Coverage: %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule

class Transaction;
    rand bit [7:0] a, b;
    rand bit sel;
endclass


module tb;

    logic [7:0] a, b, y;
    logic sel;

    mux2to1 dut (.*);

    covergroup cg_mux;
        cp_sel : coverpoint sel;
    endgroup

    cg_mux cg = new();
    Transaction tr = new();

    initial begin
        repeat (20) begin
            tr.randomize();
            a   = tr.a;
            b   = tr.b;
            sel = tr.sel;
            #5;
            cg.sample();

            if (y !== (sel ? b : a))
                $error("Mismatch!");
        end

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule

module tb;

    logic [3:0] in;
    logic [1:0] out;
    logic valid;

    priority_enc dut (.*);

    covergroup cg_enc;
        cp_in : coverpoint in {
            bins b0 = {1};
            bins b1 = {2};
            bins b2 = {4};
            bins b3 = {8};
            bins others = default;
        }
    endgroup

    cg_enc cg = new();

    initial begin
        repeat (50) begin
            in = $urandom_range(0,15);
            #5;
            cg.sample();
        end

        $display("Coverage : %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
`timescale 1ns/1ps

module tb;

    bit clk = 0;
    always #5 clk = ~clk;

    int mem[int];
    int addr;
    int data;

    covergroup mem_cg @(posedge clk);

        cp_addr: coverpoint addr {
            bins low  = {[0:33333]};
            bins mid  = {[33334:66666]};
            bins high = {[66667:100000]};
        }

        cp_data: coverpoint data {
            bins zero     = {0};
            bins non_zero = {[1:5]};
        }

        addr_data_cross: cross cp_addr, cp_data;

    endgroup

    mem_cg cg_inst = new();

    initial begin
        $dumpfile("assoc_array.vcd");
        $dumpvars(0, tb);

        addr = 100;   data = 0; mem[addr]=data; @(posedge clk); cg_inst.sample(); // low zero
        addr = 100;   data = 3; mem[addr]=data; @(posedge clk); cg_inst.sample(); // low nz

        addr = 50000; data = 0; mem[addr]=data; @(posedge clk); cg_inst.sample(); // mid zero
        addr = 50000; data = 2; mem[addr]=data; @(posedge clk); cg_inst.sample(); // mid nz

        addr = 90000; data = 0; mem[addr]=data; @(posedge clk); cg_inst.sample(); // high zero
        addr = 90000; data = 4; mem[addr]=data; @(posedge clk); cg_inst.sample(); // high nz

        foreach (mem[idx])
            $display("Addr: %0d Data: %0d", idx, mem[idx]);

        $display("Coverage = %0.2f %%", cg_inst.get_coverage());
        #20;
        $finish;
    end

endmodule

 module tb;

  mailbox #(Packet) mbx = new();

  bit clk = 0;
  bit [7:0] data_sig;

  always #5 clk = ~clk;

  // Coverage
  covergroup mbx_cov @(posedge clk);
    val_cp : coverpoint data_sig {
      bins low  = {[0:85]};
      bins mid  = {[86:170]};
      bins high = {[171:255]};
    }
  endgroup

  mbx_cov cov = new();

  // Generator
  task generator();
    Packet p;
    repeat (10) begin
      p = new();
      p.randomize();
      mbx.put(p);
      @(posedge clk);
    end
  endtask

  // Driver
  task driver();
    Packet p;
    repeat (10) begin
      mbx.get(p);
      data_sig = p.val;
      cov.sample();
      @(posedge clk);
    end
  endtask

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    fork
      generator();
      driver();
    join

    $display("Coverage = %0.2f %%", cov.get_coverage());

    #20 $finish;
  end

endmodule
module tb;

  Packet p;
  BadPacket bad = new();

  bit clk = 0;
  bit [7:0] data_sig;

  always #5 clk = ~clk;

  // Coverage on randomized packet data
  covergroup pkt_cov @(posedge clk);
    data_cp : coverpoint data_sig {
      bins low  = {[0:85]};
      bins mid  = {[86:170]};
      bins high = {[171:255]};
    }
  endgroup

  pkt_cov cov = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    // Parent handle → child object
    p = bad;

    repeat (10) begin
      @(posedge clk);

      if (!p.randomize())
        $display("Randomization failed");

      data_sig = p.data;
      cov.sample();      // coverage sampling
      p.print();
    end

    $display("Coverage = %0.2f %%", cov.get_coverage());

    #10 $finish;
  end

endmodule

  
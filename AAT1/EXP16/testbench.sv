module tb;

  bit clk = 0;
  bit rst, req;
  wire gnt;

  always #5 clk = ~clk;

  // DUT
  handshake dut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .gnt(gnt)
  );

  //---------------- Assertion ----------------//
  property p_handshake;
    @(posedge clk) req |=> ##2 gnt;
  endproperty

  assert property (p_handshake)
    else $error("Protocol Fail!");

  //---------------- Coverage ----------------//
  covergroup cg @(posedge clk);
    cp_req : coverpoint req;
    cp_gnt : coverpoint gnt;
  endgroup

  cg cov = new();

  //---------------- Stimulus ----------------//
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    rst = 1;
    @(posedge clk);
    rst = 0;

    // Generate requests
    repeat (5) begin
      @(posedge clk);
      req = 1;
      cov.sample();

      @(posedge clk);
      req = 0;
      cov.sample();
    end

    repeat (10) begin
      @(posedge clk);
      cov.sample();
    end

    $display("Coverage = %0.2f %%", cov.get_coverage());

    #20 $finish;
  end

endmodule
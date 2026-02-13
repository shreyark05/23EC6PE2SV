module top;
  bit clk;
  D_inter i1(clk);
  D_FF Dut(i1);
  test T1(i1);

  // Clock generation (5 ns period)
  always #5 clk = ~clk;

  initial begin
    $dumpfile("top.vcd");  // Generate waveform dump file
    $dumpvars;              // Dump all variables
    $monitor("time=%d, clk=%b, reset=%b, set=%b, d=%b, q=%b",
             $time, clk, i1.reset, i1.set, i1.d, i1.q); // Monitor signal values
  end
endmodule

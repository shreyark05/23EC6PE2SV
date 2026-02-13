module tb;

  // ---------------- Clock ----------------
  logic clk = 0;
  always #5 clk = ~clk;

  // ---------------- Signals ----------------
  logic rst;
  logic [5:0] sec, min;
  logic [5:0] sec_prev, min_prev;

  // ---------------- DUT ----------------
  time_counter dut (
    .clk (clk),
    .rst (rst),
    .sec (sec),
    .min (min)
  );

  // ---------------- Track previous values ----------------
  always_ff @(posedge clk) begin
    sec_prev <= sec;
    min_prev <= min;
  end

  // ---------------- COVERAGE ----------------
  covergroup cg_time @(posedge clk);

    // Verify sec rollover
    cp_sec : coverpoint sec {
      bins sec_wrap = (59 => 0);
    }

    // Verify minute increments when sec wraps
    cp_min_inc : coverpoint min iff (sec_prev == 59) {
      bins min_inc = (min_prev + 1 => min);
    }

  endgroup

  cg_time cg = new();

  // ---------------- WAVEFORM ----------------
  initial begin
    $dumpfile("time_counter_tb.vcd");
    $dumpvars(0, tb);
    $dumpvars(0, dut);
  end

  // ---------------- TEST ----------------
  initial begin
    rst = 1;
    repeat (2) @(posedge clk);
    rst = 0;

    // Enough cycles to force rollover
    repeat (130) @(posedge clk);

    $display("Time Counter Coverage = %0.2f%%",
              cg.get_inst_coverage());

    $finish;
  end

endmodule
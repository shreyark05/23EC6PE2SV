module test(D_inter.test1 t1);
  initial begin
    // Initialize signals
    t1.reset = 0; t1.set = 0; t1.d = 0;
    #10;
   
    // Apply reset and set
    t1.reset = 1; t1.set = 1; t1.d = 0;
    #10;
   
    // Release reset
    t1.reset = 0;
    t1.d = 0;
    #10;

    // Test D flip-flop behavior
    t1.d = 1; t1.set = 0;
    #10;
    t1.d = 0;
    #10;
    t1.d = 1;
    #10;
    t1.d = 0;
    #100;
   
    // End the simulation
    $finish;
  end
endmodule

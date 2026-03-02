`timescale 1ns/1ps

module clock_tb;

    logic clk;

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns period

    // Interface instance
    clock_interface intf (clk);

    // DUT instance
    digital_clock dut (
        .clk     (intf.clk),
        .reset   (intf.reset),
        .seconds (intf.seconds),
        .minutes (intf.minutes)
    );

    // Test program
    clock_test test (intf);

endmodule

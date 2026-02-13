`timescale 1ns/1ps

module atm_fsm_tb;

    logic clk;
    logic rst;
    logic card_inserted;
    logic pin_correct;
    logic balance_ok;
    logic dispense_cash;

    // DUT
    atm_fsm dut (
        .clk(clk),
        .rst(rst),
        .card_inserted(card_inserted),
        .pin_correct(pin_correct),
        .balance_ok(balance_ok),
        .dispense_cash(dispense_cash)
    );

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // ================= COVERAGE =================
    covergroup atm_cov @(posedge clk);
        coverpoint card_inserted;
        coverpoint pin_correct;
        coverpoint balance_ok;
        coverpoint dispense_cash;

        // Check valid dispense condition
        cross pin_correct, balance_ok, dispense_cash;
    endgroup

    atm_cov cov = new();

    // ================= STIMULUS =================
    initial begin
        $dumpfile("atm_fsm.vcd");
        $dumpvars(0, atm_fsm_tb);

        // Reset
        rst = 1;
        card_inserted = 0;
        pin_correct = 0;
        balance_ok = 0;

        repeat(2) @(posedge clk);
        rst = 0;

        // -------- VALID TRANSACTION --------
        @(posedge clk) card_inserted = 1;
        @(posedge clk) begin card_inserted = 0; pin_correct = 1; end
        @(posedge clk) begin pin_correct = 0; balance_ok = 1; end
        @(posedge clk) balance_ok = 0;

        // -------- WRONG PIN --------
        @(posedge clk) card_inserted = 1;
        @(posedge clk) begin card_inserted = 0; pin_correct = 0; end
        @(posedge clk);

        // -------- LOW BALANCE --------
        @(posedge clk) card_inserted = 1;
        @(posedge clk) begin card_inserted = 0; pin_correct = 1; end
        @(posedge clk) begin pin_correct = 0; balance_ok = 0; end
        @(posedge clk);

        // -------- SECOND VALID --------
        @(posedge clk) card_inserted = 1;
        @(posedge clk) begin card_inserted = 0; pin_correct = 1; end
        @(posedge clk) begin pin_correct = 0; balance_ok = 1; end
        @(posedge clk) balance_ok = 0;

        #20;

        $display("Coverage = %0.2f %%", cov.get_coverage());
        $finish;
    end

endmodule

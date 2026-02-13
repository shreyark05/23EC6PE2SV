module tb;

    logic clk;
    logic rst;
    logic [4:0] coin;
    logic dispense;

    // DUT
    vending dut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .dispense(dispense)
    );

    // Clock
    always #5 clk = ~clk;

    // -------------------------------------------------
    // COVERAGE (TOOL-SAFE VERSION)
    // -------------------------------------------------
    covergroup vending_cg @(negedge clk);

        cp_state: coverpoint dut.state {
            bins idle = {0};   // IDLE
            bins s5   = {1};   // HAS5
            bins s10  = {2};   // HAS10
        }

        cp_coin: coverpoint coin {
            bins c0  = {0};
            bins c5  = {5};
            bins c10 = {10};
        }

        cp_dispense: coverpoint dispense {
            bins yes = {1};
            bins no  = {0};
        }

    endgroup

    vending_cg cg_inst = new();

    // -------------------------------------------------
    // STIMULUS
    // -------------------------------------------------
    initial begin
        clk = 0;
        rst = 1;
        coin = 0;

        #10 rst = 0;

        // Directed stimulus (guarantees state coverage)
        coin = 5;   #10;   // IDLE -> HAS5
        coin = 10;  #10;   // HAS5 -> DISPENSE
        coin = 10;  #10;   // IDLE -> HAS10
        coin = 5;   #10;   // HAS10 -> DISPENSE
        coin = 0;   #10;

        // Random stimulus
        repeat (20) begin
            #10;
            if ($urandom_range(0,1))
                coin = 5;
            else
                coin = 10;
        end

        // Coverage report
        #20;
        $display("\n================ VENDING COVERAGE REPORT ================");
        $display("Total Functional Coverage = %0.2f %%", cg_inst.get_coverage());
        $display("========================================================\n");

        $finish;
    end

    // -------------------------------------------------
    // WAVEFORM DUMP
    // -------------------------------------------------
    initial begin
        $dumpfile("vending.vcd");
        $dumpvars(0, tb);
    end

endmodule
// Code your design here
module atm_fsm (
    input  logic clk,
    input  logic rst,
    input  logic card_inserted,
    input  logic pin_correct,
    input  logic balance_ok,
    output logic dispense_cash
);

    // State definition
    typedef enum logic [1:0] {
        IDLE      = 2'b00,
        CHECK_PIN = 2'b01,
        CHECK_BAL = 2'b10,
        DISPENSE  = 2'b11
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next-state + output logic
    always_comb begin
        next_state = state;
        dispense_cash = 0;

        case (state)
            IDLE:
                if (card_inserted)
                    next_state = CHECK_PIN;

            CHECK_PIN:
                if (pin_correct)
                    next_state = CHECK_BAL;
                else
                    next_state = IDLE;

            CHECK_BAL:
                if (balance_ok)
                    next_state = DISPENSE;
                else
                    next_state = IDLE;

            DISPENSE: begin
                dispense_cash = 1;
                next_state = IDLE;
            end
        endcase
    end

    // ================= ASSERTIONS =================

    // Cash dispensed only if pin_correct AND balance_ok
    property p_dispense_condition;
        @(posedge clk)
        dispense_cash |-> (pin_correct && balance_ok);
    endproperty
    assert property (p_dispense_condition);

    // Machine returns to IDLE after DISPENSE
    property p_return_idle;
        @(posedge clk)
        (state == DISPENSE) |=> (next_state == IDLE);
    endproperty
    assert property (p_return_idle);

endmodule

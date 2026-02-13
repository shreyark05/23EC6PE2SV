module fsm_101 (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out
);

    typedef enum logic [1:0] {S0, S1, S2} state_t;
    state_t state, next;

    always_ff @(posedge clk)
        state <= rst ? S0 : next;

    always_comb begin
        next = state;
        out  = 0;

        case (state)
            S0: if (in) next = S1;
            S1: if (in) next = S2;
                else    next = S0;
            S2: begin
                    out  = 1;
                    if (in) next = S2;
                    else    next = S0;
                end
        endcase
    end

endmodule

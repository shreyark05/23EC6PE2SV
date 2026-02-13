module handshake (
  input  logic clk,
  input  logic rst,
  input  logic req,
  output logic gnt
);

  logic [1:0] delay;

  always_ff @(posedge clk) begin
    if (rst) begin
      delay <= 0;
      gnt   <= 0;
    end
    else begin
      delay <= {delay[0], req}; // 2-cycle shift
      gnt   <= delay[1];
    end
  end

endmodule
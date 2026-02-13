`timescale 1ns/1ps

module dpram(
  input  logic clk,
  input  logic we,
  input  logic [7:0] addr,
  input  logic [7:0] wdata,
  output logic [7:0] rdata
);
  logic [7:0] mem[256];

  always_ff @(posedge clk) begin
    if (we) mem[addr] <= wdata;
    rdata <= mem[addr];
  end
endmodule
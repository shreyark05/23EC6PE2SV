module D_FF(D_inter.RTL1 rtl1);
  always @(posedge rtl1.clk, posedge rtl1.reset)
  begin
    if (rtl1.reset)
      rtl1.q <= 0;
    else if (rtl1.set)
      rtl1.q <= 1;
    else
      rtl1.q <= rtl1.d;
  end
endmodule

// D_inter.sv
interface D_inter(input bit clk);
  logic d, reset, set;
  logic q;

  modport RTL1(input clk, d, reset, set, output q);
  modport test1(input q, output d, reset, set);
endinterface: D_inter

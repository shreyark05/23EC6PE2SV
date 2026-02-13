interface D_inter(input bit clk);
  logic d, reset, set;
  logic q;

  modport RTL1(input clk, d, reset, set, output q);
  modport test1(input q, output d, reset, set);
endinterface: D_inter

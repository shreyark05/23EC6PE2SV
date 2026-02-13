module fifo(
  input wr,rd,clk,
  input [7:0]din,
  output logic full,empty
);
  logic [7:0] mem [15:0];
  logic [4:0] cnt=0;
  
  assign full =(cnt==16);
  assign empty= (cnt==0);
  
  always_ff @(posedge clk) begin
    if(wr && !full && !rd) 
      cnt<=cnt+1;;
    if(rd && !empty && !wr) 
      cnt<=cnt-1;
    
  end
endmodule 
  
  
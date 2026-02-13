class Packet;
  rand bit [7:0] data;

  // Virtual method
  virtual function void print();
    $display("Normal Packet: %h", data);
  endfunction
endclass


class BadPacket extends Packet;

  // Method override
  virtual function void print();
    $display("ERROR Packet: %h", data);
  endfunction

endclass
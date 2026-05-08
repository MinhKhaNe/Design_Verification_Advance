module testbench; 

  //TODO user code
  import uart_pkg::*;

  uart_transaction utr ;
  bit success;

  initial begin
    utr = new();
    assert(utr.randomize() with {baud_rate == 9600; parity_mode == ODD;});
    utr.display();
    assert(utr.randomize() with {baud_rate == 14400; parity_mode == EVEN;});
    utr.display();
    assert(utr.randomize() with {baud_rate == 19200; parity_mode == ODD;});
    utr.display();
    assert(utr.randomize() with {baud_rate == 115200; parity_mode == EVEN;});
    utr.display();

    #100ns; $display("[testbench] End of simulation");
    $finish;
  end
    
endmodule

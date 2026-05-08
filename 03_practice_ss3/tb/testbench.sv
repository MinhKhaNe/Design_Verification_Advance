module testbench; 

  // TODO User code
  
  import src_snk_pkg::*;

  source src;
  sink sk;
  mailbox #(packet) mb = new(1);

  initial begin

    src = new(5);
    sk = new();
    src.out_chan = mb;
    sk.in_chan = mb;

    fork
	src.run();
	sk.run();
    join_any

    $display("End of simulation");
    #100; $finish;
  end

endmodule

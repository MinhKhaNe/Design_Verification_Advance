module testbench; 

  import converter_pkg::*;
  import test_pkg::*;

  dut_if dut_if();

  parallel_to_serial dut (.clk(dut_if.clk),
  			.rst_n(dut_if.rst_n),
			.valid(dut_if.valid),
			.data_in(dut_if.data_in),	
			.TXD(dut_if.TXD));
  
  base_test 		bt;
  single_convert_test	sct;
  multi_convert_test	mct;
  
  initial begin
	dut_if.clk = 0;
	forever #25 dut_if.clk = ~dut_if.clk;
  end

  initial begin
    dut_if.rst_n = 0;
    #10;
    dut_if.rst_n = 1;

    bt = new();
    sct = new();
    mct = new();

    if($test$plusargs("single_convert_test")) begin
      bt = sct;
    end
    else if($test$plusargs("multi_convert_test")) begin
      bt = mct;
    end

    bt.dut = dut_if;
    bt.display_test();

    #5000;	
    #1us; $display("End simulation");
    $finish;
  end

endmodule

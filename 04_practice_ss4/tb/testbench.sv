module testbench; 
  import counter_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  counter_4bit u_dut(.clk(d_if.clk),
                     .rst_n(d_if.rst_n),
                     .enable(d_if.enable),
                     .up_down(d_if.up_down),
                     .count(d_if.count));

  base_test bt 		;
  count_up_test cut 	;
  count_down_test cdt 	;

  initial begin
    d_if.rst_n = 0;
    #100ns d_if.rst_n = 1;
  end

  initial begin
    d_if.clk = 0;
    forever begin 
      #10ns;
      d_if.clk = ~d_if.clk;
    end
  end

  initial begin
    $monitor("%0t: [testbench] Value of counter is %0d",$time,d_if.count);
  end

  // TODO User code - Polomorphism to archive compile one and run many times
    
  initial begin
	bt = new();
	cut = new();
	cdt = new();
	if($test$plusargs("count_up_test")) begin
		bt = cut;
	end
	else if($test$plusargs("count_down_test")) begin
		bt = cdt;
	end
 	bt.dut_vif = d_if;
	bt.run_test();
  end
endmodule

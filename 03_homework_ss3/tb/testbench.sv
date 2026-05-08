module testbench; 

  import converter_pkg::*;

  dut_if dut_if();

  parallel_to_serial dut (.clk(dut_if.clk),
  			.rst_n(dut_if.rst_n),
			.valid(dut_if.valid),
			.data_in(dut_if.data_in),	
			.TXD(dut_if.TXD));
  
  packet pkt;
  mailbox #(packet) s2s_mb = new();
  mailbox #(packet) m2s_mb = new();
  mailbox #(packet) s2d_mb = new();

  stimulus 	st;
  driver 	dr;
  monitor	mo;
  scoreboard	sc;
  
  initial begin
	dut_if.clk = 0;
	forever #25 dut_if.clk = ~dut_if.clk;
  end

  initial begin
    dut_if.rst_n = 0;
    #10;
    dut_if.rst_n = 1;

    st 		= new(5);
    dr		= new();
    mo		= new();
    sc		= new();

    st.rand_val	= s2d_mb;
    dr.dr_sig   = s2d_mb;

    st.s2s_mb   = s2s_mb;
    sc.m2s_mb	= m2s_mb;
    sc.s2s_mb	= s2s_mb;
    mo.m2s_mb	= m2s_mb;
    dr.dut	= dut_if;
    mo.dut	= dut_if;
    sc.dut	= dut_if;

    fork
	st.run();
	dr.drive();
	mo.monitor();
	sc.compare();
    join_any

    #2000;	
    #1us; $display("End simulation");
    $finish;
  end

endmodule

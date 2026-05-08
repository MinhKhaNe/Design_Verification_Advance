class environment;

	packet pkt;
	mailbox #(packet) s2s_mb, m2s_mb, s2d_mb;
	virtual dut_if dut;

	stimulus 	st;
	driver	 	dr;
	monitor  	mo;
	scoreboard 	sc;

	function new(int num);
	 	 s2s_mb = new();
                 m2s_mb = new();
                 s2d_mb = new();
  
                 st = new(num);
                 dr = new();
                 mo = new();
                 sc = new();
	endfunction

	task connect();
		st.rand_val 	= s2d_mb;
		dr.dr_sig	= s2d_mb;
		st.s2s_mb 	= s2s_mb;
		sc.s2s_mb	= s2s_mb;
		mo.m2s_mb 	= m2s_mb;
		sc.m2s_mb 	= m2s_mb;

		mo.dut = dut;
		dr.dut = dut;
		sc.dut = dut;

		$display("[Environment] Mailbox are connected");
	endtask

	task run();
		fork
		st.run();
		dr.drive();
		mo.monitor();
		sc.compare();
		$display("[Environment] Testbench is ran");
		join_any
	endtask
endclass

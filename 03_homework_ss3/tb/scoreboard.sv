class scoreboard;
	packet pkt;
	mailbox #(packet) m2s_mb,s2s_mb;
	virtual dut_if dut;

	function new();
	
	endfunction

	task compare();
		packet exp, act;
		while(1) begin
			@(posedge dut.clk)
			if(dut.valid) begin
				repeat (8) @(posedge dut.clk);
				exp = new();
				act = new();
				s2s_mb.get(exp);
				m2s_mb.get(act);

				if(exp.data != act.data) begin
					$display("[Scoreboard] Data comparison mismatch , Actual data is %h, Expected data is %h\n",act.data,exp.data);
				end
				else begin
					$display("[Scoreboard] Data comparison is matching, Actual data is %h, Expected data is %h\n",act.data,exp.data);
				end
			end
		end
	endtask
endclass

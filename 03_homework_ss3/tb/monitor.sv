class monitor;
	packet pkt;
	virtual dut_if dut;
	mailbox #(packet) m2s_mb;

	function new();
	
	endfunction

	task monitor();
		while(1) begin
			@(posedge dut.clk);
			if(dut.valid == 1'b1) begin
				pkt = new();
				$display("[Monitor] Start capture data in TXD");
				for(int i = 0; i < 8; i++) begin
					@(posedge dut.clk);
					pkt.data[i] = dut.TXD;
				end	
				m2s_mb.put(pkt);
				$display("[Monitor] Data captured is 8'h%h, sent to Scoreboard",pkt.data);
			end
		end
	endtask
endclass



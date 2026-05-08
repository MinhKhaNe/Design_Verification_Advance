class stimulus;
	mailbox #(packet) rand_val;
	mailbox #(packet) s2s_mb;
	packet pkt;
	int num;

	function new(int num);
		this.num = num;
	endfunction

	task run();
		for(int i = 0; i < num; i++) begin
			pkt = new();
			pkt.data = $urandom();
			rand_val.put(pkt);
			s2s_mb.put(pkt);
			$display("[Stimulus] Created random value %0h",pkt.data);
			$display("[Stimulus] Sent packet to Driver");
			$display("[Stimulus] Sent packet to Scoreboard");
			//#500;
		end
	endtask
endclass

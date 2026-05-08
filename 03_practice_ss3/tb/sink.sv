class sink;
	mailbox #(packet) in_chan;
	packet pkt;

	function new();
	endfunction

	task run();
		while(1) begin
			in_chan.get(pkt);
			$display("[Sink] Get packet with Pid = %0d", pkt.pid);
			#1;
		end	
	endtask
endclass


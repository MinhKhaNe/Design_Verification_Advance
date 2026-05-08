class source;
	mailbox #(packet) out_chan;
	packet pkt;
	int num;

	function new(int num);
		this.num = num;
	endfunction

	task run();
		for(int i = 0; i< num; i++) begin
			pkt = new(i);
			out_chan.put(pkt);
			$display("[Source] Send pkt with Pid = %0d", pkt.pid);	
		end
	endtask
endclass


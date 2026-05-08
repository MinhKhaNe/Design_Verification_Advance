class driver;
	mailbox #(packet) dr_sig;
	virtual dut_if dut;
	packet pkt;

	function new();
		
	endfunction

	task drive();
		while(1) begin
			dr_sig.get(pkt);
			$display("[Driver] Get packet from stimulus");
			@(posedge dut.clk);
			dut.data_in	<= pkt.data;
			dut.valid     	<= 1'b1;
			#1;
			$display("[Driver] Drive DUT with data in 8'h%h",dut.data_in);	
			@(posedge dut.clk);
			dut.data_in   	<= 8'h00;
			dut.valid 	<= 1'b0;
			repeat (7) @(posedge dut.clk);
		end
	endtask
endclass



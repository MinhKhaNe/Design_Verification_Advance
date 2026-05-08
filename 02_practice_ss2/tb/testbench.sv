module testbench; 

  mailbox #(bit[7:0]) mb = new();

  task stimulus();
    bit[7:0] pid;
    for(int i=0; i<10; i++) begin
      pid = $random;
      mb.put(pid);
      $display("%0t: Put to mailbox, pid is %0d ",$time,pid);
    end
  endtask

  semaphore ctrl = new(1);
  bit [7:0]	queue[$];
  bit [7:0]	pid, data;
  logic 	clk;

  //initial begin
//	forever #25 clk = ~clk;
  //end

  // TODO User code

  initial begin
	  clk = 0;
	fork
		stimulus();
		write();
		read();
	join_any

    #1000;
    $display("End of simulation");
    $finish;
  end

  task write();
	//@(posedge clk); 
while(1) begin
	ctrl.get(1);
	 mb.get(data);
	$display("===== t=%0t Get pid %d from mailbox =====",$time,data);
	#50;
	$display("===== t=%0t Process write is done =====",$time);
	ctrl.put(1);
end
  endtask

  task read();
	 //@(posedge clk);
 while(1) begin
	 ctrl.get(1);
         mb.get(data);
         $display("===== t=%0t Get pid %d from mailbox =====",$time,data);
         #20;
         $display("===== t=%0t Process write is done =====",$time);
	 ctrl.put(1);
 end
  endtask

endmodule

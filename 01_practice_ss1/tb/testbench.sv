module testbench; 
  reg clk, rst_n;
  reg wr_en;
  reg rd_en;
  reg[7:0]  wr_data;
  wire[7:0] rd_data;
  wire      full;
  wire      empty;

  fifo u_dut(.*);

  // Clock and reset generation
  initial begin
    clk = 0; 
    forever #10ns clk = ~clk;
  end

  initial begin
    rst_n = 0;
    #100ns; rst_n = 1;
  end

  int		fifo_ref_q[$];
  logic	[7:0]	data, data_out;

  // TODO User code
  initial begin	
    rd_en = 1'b0; wr_en = 1'b0;
    #200ns;	//Wait rst_n

    $monitor("\n===== t=%0t, Size of queue is %d =====\n",$time,fifo_ref_q.size());
    for(int i = 0; i < 8; i++) begin
	data = $random();
	fifo_ref_q.push_back(data);
	write(data);
    end

    wait(full);
    $display("\n===== t=%0t, FULL flag value is %b =====",$time,full);

    for(int i = 0; i < 8; i++) begin
	read(data);
	data_out = fifo_ref_q.pop_front();
	compare(data, data_out);
    end

    wait(empty);
    $display("\n===== t=%0t, EMPTY flag value is %b =====",$time,empty);

    $display("End simulation");
    #100ns; $finish;
  end

  task compare(input[7:0] actual, expected);
	if(actual != expected)
		$display("=====t=%0t, FAILED!!! Value mismatch, Actual value is %b, Expected value is %b=====",$time,actual,expected);
	else
		$display("=====t=%0t, PASSED SUCCESSFULLY!!!=====",$time);	
  endtask

  task write(input[7:0] data);
    $display("Write 8'h%h to DUT",data);
    @(posedge clk);
    wr_en = 1;
    wr_data = data;
    @(posedge clk);
    wr_en = 0;
    wr_data = 8'h00;
  endtask

  task read(output[7:0] data);
    @(posedge clk);
    rd_en = 1;
    @(posedge clk);
    rd_en = 0;
    #1; data = rd_data;
    $display("Read 8'h%h from DUT",data);
  endtask

endmodule

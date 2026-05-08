module testbench; 
  reg       clk;     
  reg       rst_n; 
  reg       bank_addr;
  reg [3:0] row_addr; 
  reg [7:0] col_addr; 
  reg [7:0] wr_data; 
  reg       wr_en;   
  reg       rd_en;   
  wire [7:0]rd_data; 

  sram u_dut(.*);

  // Clock and reset generation
  initial begin
    clk = 0; 
    forever #10ns clk = ~clk;
  end

  initial begin
    rst_n = 0;
    #100ns; rst_n = 1;
  end

  //int		my_queue[$];	//reference model
  bit 	[7:0]	my_queue[$];
  logic	[7:0]	data, data_out;

  initial begin
    wr_en = 1'b0; rd_en = 1'b0;
    #200ns;	//Wait reset active low
    //Write to bank 0, row 0, col 0
    bank_addr = 1'b0; row_addr = 4'b0; col_addr = 8'b0;
    $monitor("\n===== t=%0t, Size of Reference model is %d =====",$time,my_queue.size());	//Display size of queue
    
    data = $random();
    write(data);
    my_queue.push_back(data);

    //Write random 5 times
    //Write to bank 0, col 5, row 3
    data = $random();
    row_addr = 4'd3; col_addr = 8'd5;
    write(data);
    my_queue.push_back(data);

    //Write to bank 0, col 15, row 13
    data = $random();
    row_addr = 4'd13; col_addr = 8'd15;
    write(data);
    my_queue.push_back(data);

    //Write to bank 0, col 9, row 2
    data = $random();
    row_addr = 4'd2; col_addr = 8'd9;
    write(data);
    my_queue.push_back(data);
 
    //Write to bank 0, col 252, row 14
    data = $random();
    row_addr = 4'd14; col_addr = 8'd252;
    write(data);
    my_queue.push_back(data);

    //Write to bank 0, col 123, row 12
    data = $random();
    row_addr = 4'd12; col_addr = 8'd123;
    write(data);
    my_queue.push_back(data);
 
    //Write to bank 0, col 255, row 15
    data = $random();
    row_addr = 4'd15; col_addr = 8'd255;
    write(data);
    my_queue.push_back(data);

    //Write to bank 1, row 0, col 0
    bank_addr = 1'b1; row_addr = 4'b0; col_addr = 8'b0;     
    data = $random();
    write(data);
    my_queue.push_back(data);
     
    //Write random 5 times
    //Write to bank 1, col 5, row 3
    data = $random();
    row_addr = 4'd3; col_addr = 8'd5;
    write(data);
    my_queue.push_back(data);
    
    //Write to bank 1, col 15, row 13
    data = $random();
    row_addr = 4'd13; col_addr = 8'd15;
    write(data);
    my_queue.push_back(data);
    
    //Write to bank 1, col 9, row 2
    data = $random();
    row_addr = 4'd2; col_addr = 8'd9;
    write(data);
    my_queue.push_back(data);
    
    //Write to bank 1, col 252, row 14
    data = $random();
    row_addr = 4'd14; col_addr = 8'd252;
    write(data);
    my_queue.push_back(data);
  
    //Write to bank 1, col 123, row 12
    data = $random();
    row_addr = 4'd12; col_addr = 8'd123;
    write(data);
    my_queue.push_back(data);
    
    //Write to bank 1, col 255, row 15
    data = $random();
    row_addr = 4'd15; col_addr = 8'd255;
    write(data);
    my_queue.push_back(data);

    //Read data from bank 0, col 0, row 0
    bank_addr = 1'b0; col_addr = 8'b0; row_addr = 4'b0;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 5, row 3
    col_addr = 8'd5; row_addr = 4'd3;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 15, row 13
    col_addr = 8'd15; row_addr = 4'd13;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 9, row 2
    col_addr = 8'd9; row_addr = 4'd2;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 252, row 14
    col_addr = 8'd252; row_addr = 4'd14;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 123, row 12
    col_addr = 8'd123; row_addr = 4'd12;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 255, row 15
    col_addr = 8'd255; row_addr = 4'd15;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //Read data from bank 1, col 0, row 0
    bank_addr = 1'b1; col_addr = 8'b0; row_addr = 4'b0;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 5, row 3
    col_addr = 8'd5; row_addr = 4'd3;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 15, row 13
    col_addr = 8'd15; row_addr = 4'd13;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 9, row 2
    col_addr = 8'd9; row_addr = 4'd2;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 252, row 14
    col_addr = 8'd252; row_addr = 4'd14;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 123, row 12
    col_addr = 8'd123; row_addr = 4'd12;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    //col 255, row 15
    col_addr = 8'd255; row_addr = 4'd15;
    read(data);
    data_out = my_queue.pop_front();
    compare(data, data_out);

    $display("End simulation");
    #100ns; $finish;
  end

  task compare(input [7:0] actual, expected);
	if(actual != expected)
		$display("\n===== t=%0t, FAILED!!! Value mismatch, Actual value is %d, Expected value is %d =====",$time,actual,expected);
	else
		$display("\n===== t=%0t, Data matching!!! =====",$time);
  endtask

  task write(input [7:0] data);
	@(posedge clk);
	wr_en 	= 1'b1;
	wr_data = data;
	@(posedge clk);
	wr_en 	= 1'b0;
	wr_data = 8'h0;
	$display("\n===== t=%0t, Write value %d to Bank %b, Col %d, Row %d =====",$time,data,bank_addr,col_addr,row_addr);
  endtask

  task read(output [7:0] data);
	@(posedge clk);
	rd_en	= 1'b1;
	@(posedge clk);
	rd_en	= 1'b0;
	#1; data = rd_data;
	$display("\n===== t=%0t, Read data %d from Bank %b, Col %d, Row %d =====",$time,rd_data,bank_addr,col_addr,row_addr);
  endtask

endmodule

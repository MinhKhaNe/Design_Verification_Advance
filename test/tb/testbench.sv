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
	
  string a = "Hello WOrld";
  typedef enum {RED, GREEN, YELLOW} color;
  color clr;

  initial begin
	$display("%s",a);
	a[7] = "o";
	a.putc(6,"h");
	$display("%s",a);
	$display("%s %s %s",clr.last(), clr.next(1), clr.next(2).name());


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

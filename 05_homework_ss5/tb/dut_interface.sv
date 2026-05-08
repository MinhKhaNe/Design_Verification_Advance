interface dut_if;
  logic         clk;          
  logic         rst_n;        
  logic [6:0]   slave_addr;   
  logic [7:0]   data_in;      
  logic         start;        
  wire          sda;          
  wire          scl;          
  logic         done;         

  logic [15:0]  scl_low_time;   
  logic [15:0]  scl_high_time;  
  logic [15:0]  sda_setup_time; 
  logic [15:0]  sda_hold_time;

endinterface

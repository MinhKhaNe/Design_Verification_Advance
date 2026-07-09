module testbench;

  import uvm_pkg::*;
  import apb_pkg::*;
  import test_pkg::*;

  reg ker_clk;
  wire interrupt;

  /** Instantiate APB Interface */
  apb_if apb_vif();

  //instance DUT
  timer_top u_dut(
    .ker_clk(ker_clk),       
    .pclk(apb_vif.pclk),       
    .presetn(apb_vif.presetn),    
    .psel(apb_vif.psel),       
    .penable(apb_vif.penable),    
    .pwrite(apb_vif.pwrite),     
    .paddr(apb_vif.paddr),      
    .pwdata(apb_vif.pwdata),     
    .prdata(apb_vif.prdata),     
    .pready(apb_vif.pready),     
    .interrupt(interrupt));
  	
  initial begin
    apb_vif.presetn = 0;
    #100ns apb_vif.presetn = 1;
  end

  // 50 MHz
  initial begin
    apb_vif.pclk = 0;
    forever begin 
      #10ns;
      apb_vif.pclk = ~apb_vif.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    ker_clk = 1;
    forever begin 
      #2.5ns;
      ker_clk = ~ker_clk;
    end
  end

  /** Set the VIP interface on the environment */
  initial begin
    uvm_config_db#(virtual apb_if)::set(uvm_root::get(),"uvm_test_top","apb_vif",apb_vif);

    /** Start the UVM test */
    run_test();
  end

endmodule

`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt));

  bit [7:0] internal_counter;
  assign internal_counter = u_dut.u_counter.load;

  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  // 50 MHz
  initial begin
    d_if.pclk = 0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    d_if.ker_clk = 1;
    forever begin 
      #2.5ns;
      d_if.ker_clk = ~d_if.ker_clk;
    end
  end

  base_test         base;
  signal_chk        sig;
  register_chk      reg_chk;
  clk_div           div;
  counter_chk       counter;
  udf_int_chk       udf;
  ovf_int_chk       ovf;

  initial begin
    base    = new();
    sig     = new();
    reg_chk = new();
    div     = new();
    counter = new();
    udf     = new();
    ovf     = new();
    if($test$plusargs("signal_chk")) begin
      base = sig;
    end
    else if($test$plusargs("register_chk")) begin
      base = reg_chk;
    end
    else if($test$plusargs("clk_div")) begin
      base = div;
    end
    else if($test$plusargs("counter_chk")) begin
      base = counter;
      $monitor("%d",internal_counter);
    end
    else if($test$plusargs("udf_int_chk")) begin
      base = udf;
    end
    else if($test$plusargs("ovf_int_chk")) begin
      base = ovf;
    end

    base.dut = d_if;
    base.run();
    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end

    
endmodule

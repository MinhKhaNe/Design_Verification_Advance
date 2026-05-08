module testbench; 

  apb_interface apb_if();

  register u_dut(
     .pclk(apb_if.pclk),    
     .presetn(apb_if.presetn), 
     .psel(apb_if.psel),    
     .penable(apb_if.penable), 
     .pwrite(apb_if.pwrite),  
     .paddr(apb_if.paddr),   
     .pwdata(apb_if.pwdata),  
     .pready(apb_if.pready));
  
  cpu_model u_model(
     .pclk(apb_if.pclk),    
     .presetn(apb_if.presetn), 
     .psel(apb_if.psel),    
     .penable(apb_if.penable), 
     .pwrite(apb_if.pwrite),  
     .paddr(apb_if.paddr),   
     .pwdata(apb_if.pwdata),  
     .pready(apb_if.pready));
  
  initial begin
    apb_if.presetn = 0;
    #100ns apb_if.presetn = 1;
  end

  initial begin
    apb_if.pclk = 0;
    forever begin 
      #10ns;
      apb_if.pclk = ~apb_if.pclk;
    end
  end

  // Stimulus: Control CPU model write transfer to DUT
  initial begin
    bit [7:0] addr;
    bit [7:0] data;

    wait(apb_if.presetn == 1);
    addr = $urandom;
    data = $urandom;
    u_model.apb_write(addr,data); 
    addr = $urandom;
    data = $urandom;
    u_model.apb_write(addr,data); 
    #100ns;
    $display("[testbench] End of simulation");
    $finish;
  end

  // TODO user code, write assertion
  //sequence sel_en_write;
  //  (apb_if.pwrite && apb_if.psel && apb_if.penable) ##1 (!apb_if.penable && !apb_if.psel);
  //endsequence

  property write_set_up_phase;
    @(posedge apb_if.pclk) (apb_if.psel && !apb_if.penable && apb_if.pwrite) |=> (apb_if.psel && apb_if.penable && apb_if.pwrite);
  endproperty

  property write_data_phase;
    @(posedge apb_if.pclk) (apb_if.psel && !apb_if.penable && apb_if.pwrite) |=> (apb_if.psel && apb_if.penable && apb_if.pwrite && apb_if.pready);
  endproperty

  property write_data_end;
    @(posedge apb_if.pclk) (apb_if.pwrite && apb_if.psel && apb_if.penable && apb_if.pready) |=> (!apb_if.pready && !apb_if.pwrite && !apb_if.psel && !apb_if.penable);
  endproperty

  property check_stable;
    @(posedge apb_if.pclk) (apb_if.pwrite && apb_if.psel && !apb_if.penable) |=> $stable(apb_if.paddr) && $stable(apb_if.pwdata);
  endproperty

  assert property(write_set_up_phase) else $error("Timing check failure!");
  assert property(write_data_phase) else $error("Timing check failure!");
  assert property(write_data_end) else $error("Timing check failure!");
  assert property(check_stable) else $error("Timing check failure!");


endmodule

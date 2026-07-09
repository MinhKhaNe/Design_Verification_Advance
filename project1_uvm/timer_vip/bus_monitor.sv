class bus_monitor extends uvm_monitor;
  `uvm_component_utils(bus_monitor)

  virtual   timer_interface   timer_if;

  uvm_analysis_port #(timer_transaction) bus_observed_port;

  function new(string name = "bus_monitor", uvm_component parent);
    super.new(name, parent);
    bus_observed_port = new("bus_observed_port", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  endfunction

  virtual task run_phase(uvm_phase);
    timer_transaction timer_trans;
     forever begin
      @(posedge timer_if.HCLK);
      if(timer_if.psel && timer_if.penable) begin
        timer_trans.paddr       = timer_if.paddr;
        timer_trans.trans_type  = timer_transaction::transfer_type'(timer_if.pwrite);
        if(!timer_if.pwrite) begin
          timer_trans.data      = timer_if.prdata;
        end
      end
      `uvm_info("bus_monitor", $sfomatf("Data read from DUT is %0s",timer_trans.sprint()), UVM_LOW)  
      bus_observed_port.write(timer_trans);
    end
  endtask

endclass

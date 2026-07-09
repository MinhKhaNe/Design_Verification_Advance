class interrupt_monitor extends uvm_monitor;
  `uvm_component_utils(bus_monitor)

  virtual   timer_interface   timer_if;

  uvm_analysis_port #(interrupt_transaction) interrupt_observed_port;

  function new(string name = "interrupt_monitor", uvm_component parent);
    super.new(name, parent);
    interrupt_observed_port = new("interrupt_observed_port", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  endfunction

  virtual task run_phase(uvm_phase);
    interrupt_transaction interrupt_trans;
     forever begin
      @(posedge timer_if.HCLK);
      if(timer_if.interrupt) begin
        interrupt_trans.interrupt       = timer_if.interrupt;
        interrupt_trans.interrupt_time  = $time;
      end
      `uvm_info("interrupt monitor", $sfomatf("Timing read from DUT is %0s",interrupt_trans.sprint()), UVM_LOW)  
      interrupt_observed_port.write(interrupt_trans);
    end
  endtask

endclass

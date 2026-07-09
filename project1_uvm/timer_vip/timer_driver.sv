class timer_driver extends uvm_driver #(timer_transaction);
  `uvm_component_utils(timer_driver)

  virtual timer_interface   timer_if;  

  function new(string name = "timer_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
  endtask

endclass

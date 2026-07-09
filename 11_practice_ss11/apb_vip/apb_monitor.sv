class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  function new(string name="apb_monitor", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
  endtask: run_phase

endclass: apb_monitor

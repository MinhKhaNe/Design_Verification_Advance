class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  apb_monitor   monitor;
  apb_driver    driver;
  apb_sequencer sequencer;

  function new(string name="apb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

endclass: apb_agent

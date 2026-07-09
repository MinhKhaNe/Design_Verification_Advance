class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent)

  ahb_monitor   my_mo;
  ahb_driver    my_drv;
  ahb_sequencer my_se;

  function new(string name="ahb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    my_mo   = ahb_monitor::type_id::create("my_mo",this);
    my_drv  = ahb_driver::type_id::create("my_drv",this);
    my_se   = ahb_sequencer::type_id::create("my_se",this);
  endfunction: build_phase

endclass: ahb_agent

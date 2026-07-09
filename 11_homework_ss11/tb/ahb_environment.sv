class ahb_environment extends uvm_env;
  `uvm_component_utils(ahb_environment)

  ahb_agent      ahb_agt;

  function new(string name="ahb_environment", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)

    ahb_agt = ahb_agent::type_id::create("ahb_agt", this);

    `uvm_info("build_phase","Exiting...",UVM_HIGH)
  endfunction: build_phase

endclass: ahb_environment

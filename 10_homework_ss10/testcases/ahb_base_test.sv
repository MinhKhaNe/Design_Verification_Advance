class ahb_base_test extends uvm_test;
  `uvm_component_utils(ahb_base_test)

  ahb_environment ahb_bridge_env;

  function new(string name="ahb_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)

    ahb_bridge_env = ahb_environment::type_id::create("ahb_bridge_env",this);

    `uvm_info("build_phase","Exiting...",UVM_HIGH)
  endfunction: build_phase
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("end_of_elaboration_phase","Entered...",UVM_HIGH)
    uvm_top.print_topology();
    `uvm_info("end_of_elaboration_phase","Exiting...",UVM_HIGH)
  endfunction


endclass


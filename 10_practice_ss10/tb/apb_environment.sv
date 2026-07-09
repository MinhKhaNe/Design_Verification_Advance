class apb_environment extends uvm_env;

  `uvm_component_utils(apb_environment)

  apb_scoreboard apb_sb;
  apb_agent apb_ag;

  function new(string name="apb_environment", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Entered build_phase"),UVM_LOW);
    apb_ag  = apb_agent::type_id::create("apb_ag",this);
    apb_sb  = apb_scoreboard::type_id::create("apb_sb",this);
    `uvm_info(get_type_name(),$sformatf("Existing build_phase"),UVM_LOW);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Entered connect_phase"),UVM_LOW);
    `uvm_info(get_type_name(),$sformatf("Existing connect_phase"),UVM_LOW);
  endfunction: connect_phase


endclass: apb_environment

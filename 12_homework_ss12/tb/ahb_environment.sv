class ahb_environment extends uvm_env;
  `uvm_component_utils(ahb_environment)

  ahb_agent      ahb_agt;
  ahb_scoreboard ahb_sb;
  virtual   ahb_if  ahb_vif;

  function new(string name="ahb_environment", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)

    if(!uvm_config_db#(virtual ahb_if)::get(this, "", "ahb_vif", ahb_vif))
      `uvm_fatal(get_type_name(),$sformatf("FAILED to get ahb_vif from uvm_config_db"))

    ahb_agt = ahb_agent::type_id::create("ahb_agt", this);
    ahb_sb  = ahb_scoreboard::type_id::create("ahb_sb", this);

    uvm_config_db#(virtual ahb_if)::set(this, "master_agt", "ahb_vif", ahb_vif);

    `uvm_info("build_phase","Exiting...",UVM_HIGH)
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ahb_agt.monitor.a_port.connect(ahb_sb.a_export);
  endfunction

endclass: ahb_environment

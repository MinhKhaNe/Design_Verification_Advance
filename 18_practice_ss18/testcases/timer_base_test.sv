class timer_base_test extends uvm_test;
  `uvm_component_utils(timer_base_test)

  uvm_report_server  svr;
  timer_environment  env;

  timer_reg_block   regmodel;
  virtual apb_if    apb_vif;

  time usr_timeout=1s;

  function new(string name="timer_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_vif",apb_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get apb_vif from uvm_config_db"))

    env     = timer_environment::type_id::create("env",this);

    uvm_config_db#(virtual apb_if)::set(this,"env","apb_vif",apb_vif);

    uvm_top.set_timeout(usr_timeout);
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // For testcase use regmodel in short
    this.regmodel = env.regmodel;
  endfunction: connect_phase

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction: end_of_elaboration_phase
  
  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info("final_phase","Entered...",UVM_HIGH)
    svr = uvm_report_server::get_server();
    if(svr.get_severity_count(UVM_FATAL)+
       svr.get_severity_count(UVM_ERROR)) begin
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     `uvm_info(get_type_name(), "----           TEST FAILED         ----", UVM_NONE)
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
    else begin
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
     `uvm_info(get_type_name(), "----           TEST PASSED         ----", UVM_NONE)
     `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
    `uvm_info("final_phase","Exiting...",UVM_HIGH)
  endfunction: final_phase

endclass: timer_base_test

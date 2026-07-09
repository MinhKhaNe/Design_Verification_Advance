class uart_base_test extends uvm_test;
  `uvm_component_utils(uart_base_test)

  uvm_report_server  svr;
  uart_environment  env;

  uart_reg_block   regmodel;
  virtual ahb_if    ahb_vif;

  time usr_timeout=1s;

  function new(string name="uart_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ahb_if)::get(this,"","ahb_vif",ahb_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get ahb_vif from uvm_config_db"))

    env     = uart_environment::type_id::create("env",this);

    uvm_config_db#(virtual ahb_if)::set(this,"env","ahb_vif",ahb_vif);

    uvm_top.set_timeout(usr_timeout);
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
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

endclass: uart_base_test

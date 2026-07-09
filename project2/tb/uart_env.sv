class uart_env extends uvm_env;
  `uvm_component_utils(uart_env)

  uart_agent          uart_lhs_agent;
  uart_agent          uart_rhs_agent;
  uart_scoreboard     uart_sb;
  uart_configuration  uart_lhs_config;
  uart_configuration  uart_rhs_config;

  virtual   uart_if   lhs_vif;
  virtual   uart_if   rhs_vif;

  function new(string name = "uart_environment", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info("build_phase", "Entered ....", UVM_HIGH)

    if(!uvm_config_db#(uart_configuration)::get(this, "", "uart_lhs_config", uart_lhs_config))
      `uvm_fatal(get_type_name(), $sformatf("FAILED to get uart_configuration from uvm_config_db"))

    if(!uvm_config_db#(uart_configuration)::get(this, "", "uart_rhs_config", uart_rhs_config))
      `uvm_fatal(get_type_name(), $sformatf("FAILED to get uart_configuration from uvm_config_db"))

    if(!uvm_config_db#(virtual uart_if)::get(this, "", "lhs_vif", lhs_vif))
      `uvm_fatal(get_type_name(), $sformatf("FAILED to get uart_interface from uvm_config_db"))

    if(!uvm_config_db#(virtual uart_if)::get(this, "", "rhs_vif", rhs_vif))
      `uvm_fatal(get_type_name(), $sformatf("FAILED to get uart_interface from uvm_config_db"))

    uart_lhs_agent  = uart_agent::type_id::create("uart_lhs_agent", this);
    uart_rhs_agent  = uart_agent::type_id::create("uart_rhs_agent", this);
    uart_sb         = uart_scoreboard::type_id::create("uart_scoreboard", this);

    uvm_config_db#(uart_configuration)::set(this, "uart_lhs_agent", "cfg", uart_lhs_config);
    uvm_config_db#(uart_configuration)::set(this, "uart_rhs_agent", "cfg", uart_rhs_config);

    uvm_config_db#(virtual uart_if)::set(this, "uart_lhs_agent", "dut_vif", lhs_vif);
    uvm_config_db#(virtual uart_if)::set(this, "uart_rhs_agent", "dut_vif", rhs_vif);

    `uvm_info("build_phase", "Existing ....", UVM_HIGH) 
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    uart_lhs_agent.drv.uart_a_port.connect(uart_sb.uart_lhs_driver_export);
    uart_lhs_agent.mon.uart_a_port.connect(uart_sb.uart_lhs_monitor_export);
    
    uart_rhs_agent.drv.uart_a_port.connect(uart_sb.uart_rhs_driver_export);
    
  endfunction

endclass

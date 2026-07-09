class uart_base_test extends uvm_test;
  `uvm_component_utils(uart_base_test)

  uart_env  env;
  uart_configuration  uart_lhs_config;
  uart_configuration  uart_rhs_config;
  virtual   uart_if   lhs_vif;
  virtual   uart_if   rhs_vif;

  function new(string name = "uart_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    uart_lhs_config   = uart_configuration::type_id::create("uart_lhs_config", this);
    uart_rhs_config   = uart_configuration::type_id::create("uart_rhs_config", this);

    uart_lhs_config.parity_mode   = uart_configuration::UART_PARITY_NONE;
    uart_rhs_config.parity_mode   = uart_configuration::UART_PARITY_NONE;   

    if(!uvm_config_db#(virtual uart_if)::get(this, "", "lhs_vif", lhs_vif)) begin
      `uvm_fatal(get_type_name(), $sformatf("FAILED to get uart_interface from uvm_config_db"))
    end
    if(!uvm_config_db#(virtual uart_if)::get(this, "", "rhs_vif", rhs_vif)) begin
      `uvm_fatal(get_type_name(), $sformatf("FAILED to get uart_interface from uvm_config_db"))
    end

    env   = uart_env::type_id::create("env", this);
    uvm_config_db#(uart_configuration)::set(this, "*", "uart_lhs_config", uart_lhs_config);
    uvm_config_db#(uart_configuration)::set(this, "*", "uart_rhs_config", uart_rhs_config);
    uvm_config_db#(virtual uart_if)::set(this, "*", "lhs_vif", lhs_vif);
    uvm_config_db#(virtual uart_if)::set(this, "*", "rhs_vif", rhs_vif);

  endfunction

  virtual function void start_of_simulation_phase(uvm_phase phase);

  endfunction

endclass

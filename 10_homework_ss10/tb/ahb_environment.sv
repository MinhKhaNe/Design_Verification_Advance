class ahb_environment extends uvm_env;
  `uvm_component_utils(ahb_environment)

  ahb_agent   cpu_ahb_master_agent;
  ahb_agent   cpu_ahb_slave_agent;
  ahb_agent   dma_ahb_master_agent;
  ahb_agent   uart_ahb_slave_agent;

  ahb_scoreboard        my_sb;

  function new(string name="ahb_environment", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)
    cpu_ahb_master_agent  = ahb_agent::type_id::create("cpu_ahb_master_agent",this);
    cpu_ahb_slave_agent   = ahb_agent::type_id::create("cpu_ahb_slave_agent",this);
    dma_ahb_master_agent  = ahb_agent::type_id::create("dma_ahb_master_agent",this);
    uart_ahb_slave_agent  = ahb_agent::type_id::create("uart_ahb_slave_agent",this);
    my_sb                 = ahb_scoreboard::type_id::create("my_sb",this);
    `uvm_info("build_phase","Exiting...",UVM_HIGH)
  endfunction: build_phase

endclass: ahb_environment

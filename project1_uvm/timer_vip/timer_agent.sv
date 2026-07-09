class timer_agent extends uvm_agent;
  `uvm_component_utils(timer_agent)

  timer_driver        driver;
  bus_monitor         bus_monitor;
  interrupt_monitor   int_monitor;
  timer_sequencer     sequencer;

  virtual timer_interface timer_if;

  function new(string name = "timer_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(is_active == UVM_ACTIVE) begin
      `uvm_info(get_type_name(),$sformatf("Active agent is configuring"),UVM_LOW)
      sequencer     = timer_sequencer::type_id::create("sequencer", this);
      driver        = timer_driver::type_id::create("driver", this);
      bus_monitor   = bus_monitor::type_id::create("bus_monitor", this); 
      int_monitor   = interrupt_monitor::type_id::create("interrupt_monitor", this);
    end
    else begin
      `uvm_info(get_type_name(), $sformatf("Passive agent is configuring"), UVM_LOW)
      bus_monitor   = bus_monitor::type_id::create("bus_monitor", this);
      int_monitor   = interrupt_monitor::type_id::create("interrupt_monitor", this);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endtask

endclass

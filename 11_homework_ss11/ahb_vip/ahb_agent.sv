class ahb_agent extends uvm_agent;
  `uvm_component_utils(ahb_agent)

  ahb_monitor   monitor;
  ahb_driver    driver;
  ahb_sequencer sequencer;

  function new(string name="ahb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(is_active == UVM_ACTIVE) begin
      `uvm_info(get_type_name(),$sformatf("Active agent is configued"),UVM_LOW)
      driver = ahb_driver::type_id::create("driver", this);
      sequencer = ahb_sequencer::type_id::create("sequencer", this);
      monitor = ahb_monitor::type_id::create("monitor", this);
    end
    else begin
      `uvm_info(get_type_name(),$sformatf("Passive agent is configued"),UVM_LOW)
      monitor = ahb_monitor::type_id::create("monitor", this);
    end

  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin 
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction: connect_phase

endclass: ahb_agent

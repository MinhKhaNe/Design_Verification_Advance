class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  apb_monitor   monitor;
  apb_driver    driver;
  apb_sequencer sequencer;
  
  string msg="apb_agent";

  function new(string name="apb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(is_active == UVM_ACTIVE) begin
      `uvm_info(msg,$sformatf("Active agent is configured"),UVM_LOW)
      driver    = apb_driver::type_id::create("driver", this);
      sequencer = apb_sequencer::type_id::create("sequencer", this);
      monitor   = apb_monitor::type_id::create("monitor", this);
    end
    else begin
      `uvm_info(msg,$sformatf("Passive agent is configured"),UVM_LOW)
      monitor   = apb_monitor::type_id::create("monitor", this);
    end
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(is_active == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction: connect_phase

endclass: apb_agent


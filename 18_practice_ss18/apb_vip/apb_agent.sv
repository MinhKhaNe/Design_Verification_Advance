//=============================================================================
// Project       : APB VIP
//=============================================================================
// Filename      : apb_agent.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 13-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_APB_AGENT__SV
`define GUARD_APB_AGENT__SV

class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  virtual apb_if apb_vif;

  apb_monitor   monitor;
  apb_driver    driver;
  apb_sequencer sequencer;

  local string msg = "[APB_VIP][apb_AGENT]";  
  local string interface_id = "apb_if";

  function new(string name="apb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    /** Applying the virtual interface received through the config db */
    if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_vif))
      `uvm_fatal(msg,$sformatf("Failed to get %0s from uvm_config_db. Please check!",interface_id))

    /** Create component and set the virtual interface to lower component
     * Default Agent is Active mode.
     */
    if(is_active == UVM_ACTIVE) begin
      `uvm_info(msg,$sformatf("Active agent is configued"),UVM_LOW)
      driver    = apb_driver::type_id::create("driver", this);
      sequencer = apb_sequencer::type_id::create("sequencer", this);
      monitor   = apb_monitor::type_id::create("monitor", this);

      /** Pass virtual interface to sub component */
      uvm_config_db#(virtual apb_if)::set(this,"driver","apb_if",apb_vif);
      uvm_config_db#(virtual apb_if)::set(this,"monitor","apb_if",apb_vif);
    end
    else begin
      `uvm_info(msg,$sformatf("Passive agent is configued"),UVM_LOW)
      monitor = apb_monitor::type_id::create("monitor", this);

      /** Pass virtual interface to sub component */
      uvm_config_db#(virtual apb_if)::set(this,"monitor","apb_if",apb_vif);
    end
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin 
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction: connect_phase

endclass: apb_agent

`endif



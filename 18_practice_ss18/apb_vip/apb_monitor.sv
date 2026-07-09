//=============================================================================
// Project       : APB VIP
//=============================================================================
// Filename      : apb_monitor.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 13-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_APB_MONITOR__SV
`define GUARD_APB_MONITOR__SV

class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  virtual apb_if  apb_vif;
  apb_transaction trans;

  /** Analysis port, send the transaction to scoreboard */
  uvm_analysis_port #(apb_transaction) item_observed_port;

  local string msg = "[APB_VIP][APB_MONITOR]";
  local string interface_id = "apb_vif";

  function new(string name="apb_monitor", uvm_component parent);
    super.new(name,parent);
    item_observed_port = new("item_observed_port",this);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    /** Applying the virtual interface received through the config db */
    if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_vif))
      `uvm_fatal(msg,$sformatf("Failed to get %0s from uvm_config_db. Please check!",interface_id))
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);

    forever begin
      @(posedge apb_vif.penable);
      @(posedge apb_vif.pclk);
      trans = new("observed_trans");
      trans.addr = apb_vif.paddr;
      $cast(trans.xact_type,apb_vif.pwrite);
      trans.data = (trans.xact_type == apb_transaction::WRITE)? apb_vif.pwdata : apb_vif.prdata;
      `uvm_info(msg,$sformatf("Captured APB transaction:\n %s",trans.sprint()),UVM_LOW)
      item_observed_port.write(trans);
    end
  endtask

endclass: apb_monitor

`endif



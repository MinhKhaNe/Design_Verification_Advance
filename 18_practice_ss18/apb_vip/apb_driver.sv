//=============================================================================
// Project       : APB VIP
//=============================================================================
// Filename      : apb_driver.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 13-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_APB_DRIVER__SV
`define GUARD_APB_DRIVER__SV

class apb_driver extends uvm_driver #(apb_transaction);
  `uvm_component_utils(apb_driver)

  virtual apb_if apb_vif; 

  local string msg = "[APB_VIP][APB_DRIVER]";  
  local string interface_id = "apb_vif";

  function new(string name="apb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    /** Applying the virtual interface received through the config db */
    if(!uvm_config_db#(virtual apb_if)::get(this,"","apb_if",apb_vif))
      `uvm_fatal(msg,$sformatf("Failed to get %0s from uvm_config_db. Please check!",interface_id))

  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    @(posedge apb_vif.presetn);

    forever begin
      seq_item_port.get(req);
      drive(req); 
      $cast(rsp,req.clone());
      rsp.set_id_info(req);
      seq_item_port.put(rsp);
    end
  endtask: run_phase

  virtual task drive(inout apb_transaction req);
    @(posedge apb_vif.pclk); #1ps;
    apb_vif.paddr   = req.addr;
    apb_vif.pwrite  = req.xact_type;
    apb_vif.psel    = 1'b1;
    apb_vif.penable = 1'b0;
    apb_vif.pwdata  = (req.xact_type == apb_transaction::WRITE) ? req.data : 8'h00;
    @(posedge apb_vif.pclk); #1ps;
    apb_vif.penable = 1'b1;
    @(posedge apb_vif.pclk); 
    if(req.xact_type == apb_transaction::READ)
      req.data = apb_vif.prdata;
    #1ps;
    apb_vif.psel    = 1'b0;
    apb_vif.penable = 1'b0;

  endtask: drive

endclass: apb_driver
`endif



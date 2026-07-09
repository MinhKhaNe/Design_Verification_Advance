//=============================================================================
// Project       : APB VIP
//=============================================================================
// Filename      : apb_sequencer.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 13-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_APB_SEQUENCER__SV
`define GUARD_APB_SEQUENCER__SV

class apb_sequencer extends uvm_sequencer #(apb_transaction);
  `uvm_component_utils(apb_sequencer)

  function new(string name="apb_sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction: new

endclass: apb_sequencer

`endif



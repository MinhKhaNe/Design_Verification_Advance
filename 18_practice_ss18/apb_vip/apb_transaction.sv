//=============================================================================
// Project       : APB VIP
//=============================================================================
// Filename      : apb_transaction.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 13-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef APB_TRANSACTION__SV
`define APB_TRANSACTION__SV

class apb_transaction extends uvm_sequence_item;
  typedef enum bit {READ=0,WRITE=1} xact_type_enum;

  rand xact_type_enum           xact_type;
  rand bit[`APB_ADDR_WIDTH-1:0] addr;
  rand bit[`APB_DATA_WIDTH-1:0] data;

  `uvm_object_utils_begin (apb_transaction)
    `uvm_field_enum       (xact_type_enum ,xact_type      ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (addr           ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (data           ,UVM_ALL_ON |UVM_HEX )
  `uvm_object_utils_end

  function new(string name="apb_transaction");
    super.new(name);
  endfunction: new

endclass: apb_transaction

`endif



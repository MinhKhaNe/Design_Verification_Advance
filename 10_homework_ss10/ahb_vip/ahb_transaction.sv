class ahb_transaction extends uvm_sequence_item;

  typedef enum bit {
       WRITE = 1
      ,READ  = 0
  } xact_type_enum;

  rand xact_type_enum xact_type;
  rand bit[31:0]      address;
  rand bit[31:0]      data;

  `uvm_object_utils_begin (ahb_transaction)
    `uvm_field_enum       (xact_type_enum ,xact_type ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (address                   ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (data                      ,UVM_ALL_ON |UVM_HEX )
  `uvm_object_utils_end

  function new(string name="ahb_transaction");
    super.new(name);
  endfunction: new

endclass: ahb_transaction

class simple_trans extends uvm_sequence_item;
  typedef enum bit {
       WRITE = 1
      ,READ  = 0
  } xact_type_enum;

  rand bit[7:0] addr;
  rand bit[7:0] data;
  rand xact_type_enum xact_type;

  `uvm_object_utils_begin (simple_trans)
    `uvm_field_enum       (xact_type_enum ,xact_type ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (addr                      ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (data                      ,UVM_ALL_ON |UVM_HEX )
  `uvm_object_utils_end
  
  function new(string name="simple_trans");
    super.new(name);
  endfunction: new

endclass


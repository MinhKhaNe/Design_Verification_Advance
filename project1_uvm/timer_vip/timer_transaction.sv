class timer_transaction extends uvm_sequence_item;

  typedef enum bit{
    WRITE = 1,
    READ  = 0
  } transfer_type;

        bit [7:0]       paddr;
  randc bit [7:0]       data;
  rand  transfer_type   trans_type;

  `uvm_object_utils_begin   (timer_transaction)
    `uvm_field_enum         (transfer_type, trans_type, UVM_ALL_ON |UVM_HEX)
    `uvm_field_int          (paddr,                     UVM_ALL_ON |UVM_HEX)
    `uvm_field_int          (data,                      UVM_ALL_ON |UVM_HEX)
  `uvm_object_utils_end

  function new(string name = "timer_transaction");
    super.new(name);
  endfunction

endclass

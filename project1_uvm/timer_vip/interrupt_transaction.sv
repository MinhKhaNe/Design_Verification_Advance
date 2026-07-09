class interrupt_transaction extends uvm_sequence_item;

  bit   interrupt;
  time  interrupt_time;

  `uvm_object_utils_begin   (interrupt_transaction)
    `uvm_field_int          (interrupt,       UVM_ALL_ON |UVM_HEX)
    `uvm_field_int          (interrupt_time,  UVM_ALL_ON |UVM_HEX)
  `uvm_object_utils_end

  function new(string name = "interrupt_transaction");
    super.new(name);
  endfunction
endclass

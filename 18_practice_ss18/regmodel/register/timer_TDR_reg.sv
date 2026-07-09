class timer_TDR_reg extends uvm_reg;
  `uvm_object_utils(timer_TDR_reg)

  rand uvm_reg_field data;

  function new(string name="timer_TDR_reg");
    super.new(name,8,UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    // Create object instance for each field
    data = uvm_reg_field::type_id::create("data");

    // Configure each field
    data.configure(this,8,0,"RW",1'b0,8'h00,1,1,1);
  endfunction

endclass

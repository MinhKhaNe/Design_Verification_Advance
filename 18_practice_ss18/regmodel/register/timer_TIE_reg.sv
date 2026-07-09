class timer_TIE_reg extends uvm_reg;
  `uvm_object_utils(timer_TIE_reg)

  uvm_reg_field      rsvd;
  rand uvm_reg_field underflow_en;
  rand uvm_reg_field overflow_en;

  function new(string name="timer_TIE_reg");
    super.new(name,8,UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    // Create object instance for each field
    rsvd         = uvm_reg_field::type_id::create("rsvd");
    underflow_en = uvm_reg_field::type_id::create("underflow_en");
    overflow_en  = uvm_reg_field::type_id::create("overflow_en");

    // Configure each field
    rsvd.configure(this,1,2,"RO",1'b0,5'b0_0000,1,1,1);
    underflow_en.configure(this,1,1,"RW",1'b0,1'b0,1,1,1);
    overflow_en.configure(this,1,0,"RW",1'b0,1'b0,1,1,1);
  endfunction

endclass

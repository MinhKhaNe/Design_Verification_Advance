class timer_TSR_reg extends uvm_reg;
  `uvm_object_utils(timer_TSR_reg)

  uvm_reg_field      rsvd;
  rand uvm_reg_field underflow;
  rand uvm_reg_field overflow;

  function new(string name="timer_TSR_reg");
    super.new(name,8,UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    // Create object instance for each field
    rsvd       = uvm_reg_field::type_id::create("rsvd");
    underflow  = uvm_reg_field::type_id::create("underflow");
    overflow   = uvm_reg_field::type_id::create("overflow");

    // Configure each field
    rsvd.configure(this,1,2,"RO",1'b0,5'b0_0000,1,1,1);
    underflow.configure(this,1,1,"W1C",1'b0,1'b0,1,1,1);
    overflow.configure(this,1,0,"W1C",1'b0,1'b0,1,1,1);
  endfunction

endclass

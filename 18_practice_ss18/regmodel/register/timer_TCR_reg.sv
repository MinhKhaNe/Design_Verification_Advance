class timer_TCR_reg extends uvm_reg;
  `uvm_object_utils(timer_TCR_reg)

  uvm_reg_field      rsvd;
  rand uvm_reg_field clk_div;
  rand uvm_reg_field load;
  rand uvm_reg_field count_down;
  rand uvm_reg_field timer_en;

  function new(string name="timer_TCR_reg");
    super.new(name,8,UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    // Create object instance for each field
    rsvd       = uvm_reg_field::type_id::create("rsvd");
    clk_div    = uvm_reg_field::type_id::create("clk_div");
    load       = uvm_reg_field::type_id::create("load");
    count_down = uvm_reg_field::type_id::create("count_down");
    timer_en   = uvm_reg_field::type_id::create("timer_en");

    // Configure each field
    rsvd.configure(this,3,5,"RO",1'b0,3'b000,1,1,1);
    clk_div.configure(this,2,3,"RW",1'b0,2'b00,1,1,1);
    load.configure(this,1,2,"RW",1'b0,1'b0,1,1,1);
    count_down.configure(this,1,1,"RW",1'b0,1'b0,1,1,1);
    timer_en.configure(this,1,0,"RW",1'b0,1'b0,1,1,1);
  endfunction

endclass


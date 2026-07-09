class timer_reg_block extends uvm_reg_block;
  `uvm_object_utils(timer_reg_block)

  rand timer_TCR_reg  TCR;
  rand timer_TSR_reg  TSR;
  rand timer_TDR_reg  TDR;
  rand timer_TIE_reg  TIE;
  
  uvm_reg_map apb_map;

  function new(string name="timer_reg_block");
    super.new(name,UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    TCR = timer_TCR_reg::type_id::create("TCR");
    TCR.configure(this);
    TCR.build();
    
    TSR = timer_TSR_reg::type_id::create("TSR");
    TSR.configure(this);
    TSR.build();

    TDR = timer_TDR_reg::type_id::create("TDR");
    TDR.configure(this);
    TDR.build();
    
    TIE = timer_TIE_reg::type_id::create("TIE");
    TIE.configure(this);
    TIE.build();

    apb_map = create_map("apb_map",'h0,1,UVM_LITTLE_ENDIAN);

    apb_map.add_reg(TCR,`UVM_REG_ADDR_WIDTH'h00, "RW");
    apb_map.add_reg(TSR,`UVM_REG_ADDR_WIDTH'h01, "RW");
    apb_map.add_reg(TDR,`UVM_REG_ADDR_WIDTH'h02, "RW");
    apb_map.add_reg(TIE,`UVM_REG_ADDR_WIDTH'h03, "RW");

    lock_model();
  endfunction

endclass


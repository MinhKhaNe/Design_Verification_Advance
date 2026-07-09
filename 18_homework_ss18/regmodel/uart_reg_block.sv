class uart_reg_block extends uvm_reg_block;
  `uvm_object_utils(uart_reg_block)

  rand uart_MDR_reg MDR;
  rand uart_DLL_reg DLL;
  rand uart_DLH_reg DLH;

  uvm_reg_map ahb_map;

  function new(string name="uart_reg_block");
    super.new(name,UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    MDR = uart_MDR_reg::type_id::create("MDR");
    MDR.configure(this);
    MDR.build();
    
    DLL = uart_DLL_reg::type_id::create("DLL");
    DLL.configure(this);
    DLL.build();

    DLH = uart_DLH_reg::type_id::create("DLH");
    DLH.configure(this);
    DLH.build();
    
    ahb_map = create_map("ahb_map",0,4,UVM_LITTLE_ENDIAN);

    ahb_map.add_reg(MDR, `UVM_REG_ADDR_WIDTH'h00, "RW");
    ahb_map.add_reg(DLL, `UVM_REG_ADDR_WIDTH'h04, "RW");
    ahb_map.add_reg(DLH, `UVM_REG_ADDR_WIDTH'h08, "RW");

    lock_model();
  endfunction

endclass

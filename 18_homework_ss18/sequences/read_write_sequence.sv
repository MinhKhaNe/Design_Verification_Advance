class read_write_sequence extends uvm_sequence #(ahb_transaction);
  `uvm_object_utils(read_write_sequence)

  uart_reg_block  regmodel;
  uvm_status_e    status;
  uvm_reg_data_t  data;

  function new(string name = "read_write_sequence");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.MDR.write(status, 32'hFF);
    regmodel.MDR.read(status, data);

    regmodel.DLL.write(status, 32'hFF);
    regmodel.DLL.read(status, data);

    regmodel.DLH.write(status, 32'hFF);
    regmodel.DLH.read(status, data);

  endtask
endclass

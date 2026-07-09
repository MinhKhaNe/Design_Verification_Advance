class apb_read_sequence extends uvm_sequence #(apb_transaction);
  `uvm_object_utils(apb_read_sequence)

  function new(string name="apb_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "ENTERED...",UVM_LOW)
    req = apb_transaction::type_id::create("req");
    start_item(req);
    if(req.randomize() with {xact_type == READ;})
      `uvm_info("body",$sformatf("Transaction randomize is %s",req.sprint()),UVM_LOW)
    else
      `uvm_fatal("body", "Randomize FAILED!")
    finish_item(req);
    get_response(rsp);
    `uvm_info("body",$sformatf("Transaction received is %s",rsp.sprint()),UVM_LOW)  
    `uvm_info("Body",$sformatf("Data read from DUT: %0h",rsp.data),UVM_LOW);
    `uvm_info("body","EXISTING....",UVM_LOW)
  endtask

endclass

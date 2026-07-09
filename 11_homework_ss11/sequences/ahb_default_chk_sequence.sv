class ahb_default_chk_sequence extends uvm_sequence #(ahb_transaction);
  `uvm_object_utils(ahb_default_chk_sequence)

  function new(string name="ahb_default_chk_sequence");
    super.new(name);
  endfunction

  virtual task body();
      req = ahb_transaction::type_id::create("req");
      start_item(req);
      req.randomize() with {addr        == 10'h000;
                            xact_type   == ahb_transaction::READ;
                            burst_type  == ahb_transaction::SINGLE;
                            xfer_size   == ahb_transaction::SIZE_32BIT;};
      `uvm_info(get_type_name(),$sformatf("Send req to driver: \n %s",req.sprint()),UVM_LOW);
      finish_item(req);
      get_response(rsp);

      if(rsp.data != 32'h0) begin
        `uvm_error("MDR_DEFAULT_FAILED",$sformatf("MDR real value is %0h",rsp.data))
      end
      start_item(req);
      req.randomize() with {addr        == 10'h004;
                            xact_type   == ahb_transaction::READ;
                            burst_type  == ahb_transaction::SINGLE;
                            xfer_size   == ahb_transaction::SIZE_32BIT;};
      `uvm_info(get_type_name(),$sformatf("Send req to driver: \n %s",req.sprint()),UVM_LOW);
      finish_item(req);
      get_response(rsp);

      if(rsp.data != 32'h0) begin
        `uvm_error("DLL_DEFAULT_FAILED",$sformatf("DLL real value is %0h",rsp.data))
      end
      start_item(req);
      req.randomize() with {addr        == 10'h008;
                            xact_type   == ahb_transaction::READ;
                            burst_type  == ahb_transaction::SINGLE;
                            xfer_size   == ahb_transaction::SIZE_32BIT;};
      `uvm_info(get_type_name(),$sformatf("Send req to driver: \n %s",req.sprint()),UVM_LOW);
      finish_item(req);
      get_response(rsp);

      if(rsp.data != 32'h0) begin
        `uvm_error("DLH_DEFAULT_FAILED",$sformatf("DLH real value is %0h",rsp.data))
      end

     #1us;
    `uvm_info(get_type_name(),$sformatf("Recevied rsp to driver: \n %s",rsp.sprint()),UVM_LOW);
  endtask

endclass

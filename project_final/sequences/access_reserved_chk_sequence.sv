class access_reserved_chk_sequence extends uvm_sequence #(ahb_transaction);
  `uvm_object_utils(access_reserved_chk_sequence)

  function new(string name = "access_reserved_chk_sequence");
    super.new(name);
  endfunction

  virtual task body();
    for(int i = 0; i < 10; i++) begin
      req   = ahb_transaction::type_id::create("req");

      start_item(req);

      req.HWRITE  = 1'b1;
      req.HADDR   = ;
      req.HDWDATA = 32'hFFFF;
    end
  endtask

endclass

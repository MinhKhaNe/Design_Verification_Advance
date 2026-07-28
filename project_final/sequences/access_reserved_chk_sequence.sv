class access_reserved_chk_sequence extends uvm_sequence #(ahb_transaction);
  `uvm_object_utils(access_reserved_chk_sequence)

  function new(string name = "access_reserved_chk_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0] address;
    bit [31:0] wdata;
    bit [31:0] rdata;

    for(int i = 0; i < 10; i++) begin
      address = 32'h020 + $urandom_range(0, 1023);
      wdata   = $urandom();
 
      write_read(address, wdata, rdata);
      if(rdata != 32'hFFFF_FFFF) begin
        `uvm_error("ACCESS RESERVED", $sformatf("\n===== FAILED!!! Actual data is %h, Expected data is %h =====",rdata,32'hFFFF_FFFF))
      end
      else begin
        `uvm_info("ACCESS RESERVED", $sformatf("\n===== PASSED SUCCESSFULLY!!! ====="), UVM_LOW)
      end
    end
  endtask

  task write_read(bit [31:0] haddr, bit [31:0] hwdata, bit [31:0] hrdata);
    ahb_transaction req;
    //FOR WRITE TRANSACTION
    req   = ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      addr        == haddr;
      data        == hwdata;
      xact_type   == ahb_transaction::WRITE;
      xfer_size   == ahb_transaction::SIZE_32BIT; //WORD
      burst_type  == ahb_transaction::SINGLE;
    });
    finish_item(req);

    //FOR READ TRANSACTION
    req   = ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      addr        == haddr;
      xact_type   == ahb_transaction::READ;
      xfer_size   == ahb_transaction::SIZE_32BIT; //WORD
      burst_type  == ahb_transaction::SINGLE;
    });
    finish_item(req);

    hrdata = req.data;
  endtask

endclass

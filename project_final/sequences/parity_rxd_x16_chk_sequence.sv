class parity_rxd_x16_chk_sequence extends uvm_sequence;
  `uvm_object_utils(parity_rxd_x16_chk_sequence)

  ahb_transaction     ahb_trans;
  uart_transaction    req;
  uart_configuration  cfg;

  localparam  MDR = 10'h000;
  localparam  DLL = 10'h004;
  localparam  DLH = 10'h008;
  localparam  LCR = 10'h00C;
  localparam  IER = 10'h010;
  localparam  FSR = 10'h014;
  localparam  TBR = 10'h018;
  localparam  RBR = 10'h01C;

  bit [31:0] lcr_value[3] = '{32'h20, 32'h28, 32'h38};

  function new(string name = "parity_rxd_x16_chk_sequence");
    super.new(name);
  endfunction

  virtual task body();
    bit [31:0]  wdata;
    bit [7:0]   exp, act;
    bit         hresp;

    //for(int i = 0; i < 3; i++) begin
      wdata = $urandom();
      exp   = wdata[4:0]; 

      //Settings DUT
      write_ahb(MDR, 32'h00);
      write_ahb(DLL, 32'h36);
      write_ahb(DLH, 32'h00);
      if(cfg.parity_mode == uart_configuration::UART_PARITY_ODD) begin
        write_ahb(LCR, 32'h28);
      end
      else if(cfg.parity_mode == uart_configuration::UART_PARITY_EVEN) begin
        write_ahb(LCR, 32'h38);
      end
      else begin
        write_ahb(LCR, 32'h20);
      end
      
      req   = uart_transaction::type_id::create("req");
      start_item(req);
      req.direction = uart_transaction::TX;
      req.data      = wdata;
      
      finish_item(req);
      get_response(rsp);
      #400us;
      read_ahb(RBR, act, hresp);
      if(exp != act) begin
        `uvm_error(get_type_name(), $sformatf("\n===== FAILED!!! Actual data is %h, Expected data is %h =====", act, exp))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY!!! ====="), UVM_LOW)
      end
    //end
  endtask

  task write_ahb(bit [9:0] haddr, bit [31:0] hwdata);
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
    get_response(rsp);
 endtask

   task read_ahb(bit [9:0] haddr, output bit [31:0] hrdata, output bit hresp);
    ahb_transaction req;
    ahb_transaction rsp;
 
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
    get_response(rsp);
    hrdata  = rsp.data;
    hresp   = rsp.hresp;
 endtask


endclass

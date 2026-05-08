class driver;

  mailbox #(packet) s2d_mb;
  packet  pkt;
  virtual dut_if dut;
  event   xfer_done;

  function new(virtual dut_if dut, mailbox #(packet) s2d_mb);
    this.dut = dut;
    this.s2d_mb = s2d_mb;
  endfunction

  task run();
    while(1) begin
      pkt = new();
      s2d_mb.get(pkt);  //Get packet from Stimulus
      
      @(posedge dut.pclk);
      //Setup phase
      #1;
      dut.pwrite  <= pkt.pwrite;
      dut.psel    <= pkt.psel;
      dut.paddr   <= pkt.paddr;
      dut.penable <= 1'b0;
      if(pkt.pwrite) begin
        dut.pwdata  <= pkt.pwdata;
      end

      @(posedge dut.pclk);
      //Access phase
      #1;
      dut.penable <= 1'b1;
      if(!pkt.pwrite) begin
        pkt.prdata <= dut.prdata;
      end

      @(posedge dut.pclk);
      #1;
      dut.psel    <= 1'b0;
      dut.penable <= 1'b0;
      -> xfer_done;
        
      $display("[Driver] Data is sent to DUT");
    end
  endtask

endclass

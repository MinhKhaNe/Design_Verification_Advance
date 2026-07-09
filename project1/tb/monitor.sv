class monitor;

  mailbox #(packet) m2s_mb;
  packet pkt;
  virtual dut_if dut;

  function new(virtual dut_if dut, mailbox #(packet) m2s_mb);
    this.m2s_mb = m2s_mb;
    this.dut = dut;
  endfunction

  task run();
    while(1) begin
      @(posedge dut.pclk);
      #1;
      if(dut.psel && dut.penable) begin   //Take value at Access phase
        pkt         = new();
        pkt.paddr   = dut.paddr;
        if(!dut.pwrite) begin
          pkt.data  = dut.prdata;
        end
        pkt.intr    = dut.interrupt;
        m2s_mb.put(pkt);
        $display("[Monitor] Data is sent to Scoreboard");
      end
    end
  endtask

endclass

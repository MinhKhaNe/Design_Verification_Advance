class driver;
  mailbox #(packet) s2d_mb;
  virtual dut_if dut_vif;

  function new(virtual dut_if dut_vif, mailbox #(packet) s2d_mb);
    this.dut_vif = dut_vif;
    this.s2d_mb  = s2d_mb;
  endfunction

  task run();
    packet pkt;

    // Init signal
    dut_vif.up_down = 1'b0;
    dut_vif.enable  = 1'b0;

    while(1) begin
      s2d_mb.get(pkt);
      $display("%0t: [driver] Get packet from stimulus",$time);
      @(posedge dut_vif.clk);
      dut_vif.up_down = pkt.up_down;
      dut_vif.enable  = pkt.enable;
    end
  endtask

endclass



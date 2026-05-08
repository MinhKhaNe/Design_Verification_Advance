class driver;
  mailbox #(packet) s2d_mb;
  virtual dut_if dut_vif;

  function new(virtual dut_if dut_vif, mailbox #(packet) s2d_mb);
    this.dut_vif = dut_vif;
    this.s2d_mb  = s2d_mb;
  endfunction

  task run();
    packet pkt;

    while(1) begin
      s2d_mb.get(pkt);
      $display("%0t: [driver] Get packet from stimulus",$time);
      @(posedge dut_vif.clk);
      dut_vif.slave_addr = pkt.slave_addr;
      dut_vif.data_in    = pkt.data_in;
      dut_vif.start      = 1'b1;
      dut_vif.scl_low_time   =  pkt.scl_low_time;
      dut_vif.scl_high_time  =  pkt.scl_high_time;
      dut_vif.sda_hold_time  =  pkt.sda_hold_time;
      @(posedge dut_vif.clk);
      dut_vif.slave_addr = 7'h00;
      dut_vif.data_in    = 8'h00;
      dut_vif.start      = 1'b0;
      dut_vif.scl_low_time   =  16'h0000;
      dut_vif.scl_high_time  =  16'h0000;
      dut_vif.sda_hold_time  =  16'h0000;
      wait(dut_vif.done == 1); 
    end
  endtask

endclass



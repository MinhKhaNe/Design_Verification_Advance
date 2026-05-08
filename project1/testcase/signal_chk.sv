class signal_chk extends base_test;

  function new();
    super.new();
  endfunction

  virtual task write_new(bit [7:0] paddr, bit [7:0] pwdata);
    packet pkt  = new();
    pkt.paddr   = paddr;
    pkt.pwdata  = pwdata;
    pkt.pwrite  = 1'b1;
    pkt.psel    = 1'b0;
    env.stim.send_pkt(pkt);
    @(env.drv.xfer_done);
    $display("[Signal check] Write finished! Write Data %h at Address %h",pwdata,paddr);
  endtask

  virtual task run_scenario();
    bit [7:0] data;
    $display("\n===== t=%0t Case 1.1 Reset signal check =====\n",$time);
    dut.presetn = 1'b0;
    write(8'h00, 8'h01);  //Start count
    read(8'h00, data);    //Read TCR value
    compare(8'h00, data);  //Compare with expected value

    $display("\n===== t=%0t Case 1.2 Psel signal check =====\n",$time);
    dut.presetn = 1'b1;
    @(posedge dut.pclk);
    #1;
    write_new(8'h00, 8'h00);
    read(8'h00, data);
    compare(8'h00, data);
    repeat (64) @(posedge dut.pclk);
    read(8'h01,data);     //Read TSR register
    compare(8'h00, data); //Check overflow status
  endtask

endclass

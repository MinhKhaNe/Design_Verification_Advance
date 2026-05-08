class i2c_fast_test extends base_test;

  packet pkt;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    pkt = new();
    $display("%0t: [testbench] Run i2c_fast_test",$time);
    pkt.randomize() with {i2c_mode == FAST;};
    #100;
    send_pkt(pkt);
  endtask

endclass

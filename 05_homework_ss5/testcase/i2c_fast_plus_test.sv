class i2c_fast_plus_test extends base_test;

  packet pkt = new();

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    $display("%0t: [testbench] Run i2c_fast_plus_test",$time);
    pkt.randomize() with {i2c_mode == FAST_PLUS;};
    #100;
    send_pkt(pkt);
  endtask

endclass

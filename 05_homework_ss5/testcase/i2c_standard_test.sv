class i2c_standard_test extends base_test;

  packet pkt = new();

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    $display("%0t: [testbench] Run i2c_standard_test",$time);
    if (!pkt.randomize() with {i2c_mode == STANDARD;}) begin
      $error("Randomize FAILED");
    end
    #100;
    send_pkt(pkt);
  endtask

endclass

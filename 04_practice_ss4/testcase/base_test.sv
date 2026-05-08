class base_test;

  stimulus    stim;
  driver      drv;

  mailbox #(packet) s2d_mb;

  virtual dut_if dut_vif;

  function new();
  endfunction

  function void build();
    s2d_mb = new(1);
    stim = new(s2d_mb);
    drv  = new(dut_vif, s2d_mb);
    $display("%0t: [base_test] build",$time);
  endfunction

  task create_pkt(up_down=1'b1);
    stim.create_pkt(up_down);
  endtask

  // User scenario test definition in child class
  virtual task run_scenario();
  endtask

  task run_test();
    build();
    fork
      stim.run();
      drv.run();
      run_scenario();
    join_any
    #1us;
    $display("%0t: [base_test] End simulation",$time);
    $finish;
  endtask


endclass

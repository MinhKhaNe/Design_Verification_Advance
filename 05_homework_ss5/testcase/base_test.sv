class base_test;

  environment env;
  virtual dut_if dut_vif;

  function new();
  endfunction

  function void build();
    env = new(dut_vif); 
    env.build();
  endfunction

  task send_pkt(packet pkt);
    env.stim.create_pkt(pkt);
  endtask

  // User scenario test definition
  virtual task run_scenario();
  endtask

  task run_test();
    build();
    fork
      env.run();
      run_scenario();
    join_any
    #300us;
    $display("%0t: [base_test] End simulation",$time);
    $finish;
  endtask


endclass

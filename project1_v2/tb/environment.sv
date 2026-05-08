class environment;

  stimulus    stim;
  driver      drv;
  monitor     mon;
  scoreboard  sb;

  mailbox #(packet) s2d_mb;
  mailbox #(packet) m2s_mb;
  virtual dut_if dut;

  function new(virtual dut_if dut);
    $display("[Environment] Environment is building");
    this.dut = dut;
    s2d_mb = new();
    m2s_mb = new();

    stim  = new(s2d_mb);
    drv   = new(dut, s2d_mb);
    mon   = new(dut, m2s_mb);
    sb    = new(m2s_mb);
  endfunction

  task run();
    fork
      stim.run();
      drv.run();
      mon.run();
      sb.run();
    join
  endtask

endclass

class count_down_test extends base_test;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
  	create_pkt(1'b0);
  endtask
endclass

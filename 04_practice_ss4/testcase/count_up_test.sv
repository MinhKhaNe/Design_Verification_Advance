class count_up_test extends base_test;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
  	create_pkt(1'b1);
  endtask
endclass

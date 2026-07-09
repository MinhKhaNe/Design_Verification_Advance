class timer_count_up_test extends timer_base_test;
  `uvm_component_utils(timer_count_up_test)

  function new(string name="timer_count_up_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual task run_phase(uvm_phase phase); 
    phase.raise_objection(this);
    phase.drop_objection(this);
  endtask

endclass

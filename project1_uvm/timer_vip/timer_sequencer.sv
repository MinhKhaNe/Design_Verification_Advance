class timer_sequencer extends uvm_sequencer #(timer_transaction);
  `uvm_component_utils(timer_sequencer)

  local string msg = "[APB_TIMER][TIMER_SEQUENCER]";

  function new(string name = "timer_sequencer");
    super.new(name);
  endfunction

endclass

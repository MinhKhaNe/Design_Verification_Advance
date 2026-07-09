class ahb_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(ahb_scoreboard)

  uvm_analysis_imp#(ahb_transaction, ahb_scoreboard) a_export;

  function new(string name="ahb_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a_export  = new("a_export", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    
  endtask

  virtual function void write(ahb_transaction ahb_trans);
    `uvm_info("ahb_scoreboard",$sformatf("Get packet from ahb: %0s",ahb_trans.sprint()), UVM_LOW)
  endfunction

endclass

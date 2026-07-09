class apb_read_test extends apb_base_test;
  `uvm_component_utils(apb_read_test)

  function new(string name="apb_read_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual task run_phase(uvm_phase phase);
    apb_read_sequence   seq;
    phase.raise_objection(this);
    `uvm_info("apb_read_test","Start read test",UVM_LOW)
    seq   = apb_read_sequence::type_id::create("seq");
    seq.start(apb_env.apb_agt.sequencer);
    `uvm_info("apb_read_test","Finish APB read test",UVM_LOW)
    phase.drop_objection(this);
  endtask

endclass


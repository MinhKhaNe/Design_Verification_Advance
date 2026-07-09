class ahb_default_chk extends ahb_base_test;
  `uvm_component_utils(ahb_default_chk)

  ahb_default_chk_sequence read_seq;

  function new(string name="ahb_default_chk", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    read_seq = ahb_default_chk_sequence::type_id::create("default_seq");
    read_seq.start(ahb_env.ahb_agt.sequencer);

    phase.drop_objection(this);
  endtask

endclass


class ahb_read_write_register_chk extends ahb_base_test;
  `uvm_component_utils(ahb_read_write_register_chk)

  ahb_write_sequence  wr_seq;
  ahb_read_sequence   rd_seq;

  function new(string name="ahb_read_write_register_chk", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    wr_seq = ahb_write_sequence::type_id::create("write_seq");
    wr_seq.start(ahb_env.ahb_agt.sequencer);

    rd_seq = ahb_read_sequence::type_id::create("read_seq");
    rd_seq.start(ahb_env.ahb_agt.sequencer);

    phase.drop_objection(this);
  endtask

endclass


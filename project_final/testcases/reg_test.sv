class reg_test extends base_test;
  `uvm_component_utils(reg_test)

  default_value_chk_sequence  def_seq;

  function new(string name = "reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
     
    def_seq   = default_value_chk_sequence::type_id::create("def_seq");

    def_seq.regmodel  = env.regmodel;

    def_seq.start(null);

    phase.drop_objection(this);
  endtask
endclass

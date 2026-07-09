class uart_reg_scan_test extends uart_base_test;
  `uvm_component_utils(uart_reg_scan_test)

  default_check_sequence  def_seq;
  read_write_sequence     rw_seq;

  function new(string name="uart_reg_scan_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual task run_phase(uvm_phase phase); 
    phase.raise_objection(this);

    def_seq = default_check_sequence::type_id::create("def_seq");
    rw_seq  = read_write_sequence::type_id::create("rw_seq");

    def_seq.regmodel  = env.regmodel;
    rw_seq.regmodel   = env.regmodel;

    def_seq.start(null);
    rw_seq.start(null);

    phase.drop_objection(this);
  endtask

endclass

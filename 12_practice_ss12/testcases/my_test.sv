class my_test extends uvm_test;
  `uvm_component_utils(my_test)
   env my_env;

   function new(string name = "my_test", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      my_env = env::type_id::create("my_env", this); // Create the environment
   endfunction

   virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #100ns;
    phase.drop_objection(this);
   endtask
endclass


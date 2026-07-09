class env extends uvm_env;
  `uvm_component_utils(env)

   producer prod;
   consumer cons;

  uvm_tlm_fifo #(simple_trans) tlm_fifo;

   // Constructor
   function new(string name = "env", uvm_component parent);
      super.new(name, parent);
   endfunction

   // Build phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      prod = producer::type_id::create("prod", this); // Instantiate producer
      cons = consumer::type_id::create("cons", this); // Instantiate consumer
      tlm_fifo = new("tlm_fifo", this, 2);
   endfunction

   // Connect phase
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      prod.put_port.connect(tlm_fifo.put_export);
      cons.get_port.connect(tlm_fifo.get_export);
   endfunction

   virtual task run_phase(uvm_phase phase);
      forever begin
        #5001ps;
        if(tlm_fifo.is_full())
          `uvm_info(get_type_name(),"FIFO is full",UVM_LOW)
        else if(tlm_fifo.is_empty())
          `uvm_info(get_type_name(),"FIFO is Empty",UVM_LOW)
        else
          `uvm_info(get_type_name(),$sformatf("Num of FIFO is occupy %0d",tlm_fifo.used()),UVM_LOW)
      end
   endtask

endclass


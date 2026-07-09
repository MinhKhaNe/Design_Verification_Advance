class producer extends uvm_component;
  `uvm_component_utils(producer)

  uvm_blocking_put_port #(simple_trans) put_port;

  function new(string name="producer", uvm_component parent);
    super.new(name,parent);
    put_port = new("put_port",this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    simple_trans trans;
    for(int i=0; i<6; i++) begin
      //Generate trans
      trans = simple_trans::type_id::create("trans");
      trans.randomize();
      put_port.put(trans); 
      `uvm_info(get_type_name(),"Send trans to FIFO",UVM_LOW);
      #5ns;
    end
  endtask

endclass


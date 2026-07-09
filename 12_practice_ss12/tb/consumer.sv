class consumer extends uvm_component;
  `uvm_component_utils(consumer)

  uvm_blocking_get_port #(simple_trans) get_port;

  function new(string name="consumer", uvm_component parent);
    super.new(name,parent);
    get_port = new("get_port",this);
  endfunction

  
  virtual task run_phase(uvm_phase phase);
    simple_trans trans;
    for(int i=0; i<6; i++) begin
      get_port.get(trans); 
      `uvm_info(get_type_name(),"Get trans from FIFO",UVM_LOW);
      #10ns;
    end
  endtask

endclass


class apb_driver extends uvm_driver #(apb_transaction);
  `uvm_component_utils(apb_driver)

  function new(string name="apb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

endclass: apb_driver


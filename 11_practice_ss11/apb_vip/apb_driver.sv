class apb_driver extends uvm_driver #(apb_transaction);
  `uvm_component_utils(apb_driver)

  function new(string name="apb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get(req);
      `uvm_info("driver",$sformatf("Driver received req address = 0x%0h",req.address),UVM_LOW)
      #10ns;
      $cast(rsp,req.clone());
      rsp.set_id_info(req);
      rsp.data  = 32'hCAFE_CAFE;
      seq_item_port.put(rsp);
      `uvm_info("driver",$sformatf("Driver sent rsp data = 0x%0h",rsp.data),UVM_LOW);
    end
  endtask

endclass: apb_driver


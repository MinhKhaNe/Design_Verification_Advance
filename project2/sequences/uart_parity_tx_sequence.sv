class uart_parity_tx_sequence extends uvm_sequence #(uart_transaction);
  `uvm_object_utils(uart_parity_tx_sequence)

  function new(string name = "uart_parity_tx_sequence");
    super.new(name);
  endfunction

  virtual task body();
    for(int i = 0; i < 1; i++) begin
      req   = uart_transaction::type_id::create("req");
      
      start_item(req);

      req.randomize() with {direction == uart_transaction::TX;
                            data == 9'hBB;
                            };

      //`uvm_info(get_type_name(), $sformatf("Send config info to DRIVER: \n %0s", req.sprint()), UVM_HIGH)

      finish_item(req);
      get_response(rsp);
    end
  endtask

endclass

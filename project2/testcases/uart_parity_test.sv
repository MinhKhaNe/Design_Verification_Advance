class uart_parity_test extends uart_base_test;
  `uvm_component_utils(uart_parity_test)

  uart_parity_tx_sequence  lhs_sequence;
  uart_parity_rx_sequence  rhs_sequence;

  function new(string name = "uart_parity_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    for(int i = 0; i < 3; i++) begin
      uart_lhs_config.randomize() with {data_width  == 5;
                          num_of_stop_bit == 1;
                          baud_rate == 4800;
                          parity_mode == i;
                         };
      uart_rhs_config.randomize() with {data_width == 5;
                          num_of_stop_bit == 1;
                          baud_rate == 4800;
                          parity_mode == i;
                          };
      //`uvm_info(get_type_name(), $sformatf("UART_LHS_CONFIG info: %0s",uart_lhs_config.sprint()), UVM_LOW)
      `uvm_info(get_type_name(), $sformatf("UART_RHS_CONFIG info: %0s",uart_rhs_config.sprint()), UVM_LOW)
 
      lhs_sequence   = uart_parity_tx_sequence::type_id::create("lhs_sequence", this);
      rhs_sequence   = uart_parity_rx_sequence::type_id::create("rhs_sequence", this);

      lhs_sequence.start(env.uart_lhs_agent.seq);
      rhs_sequence.start(env.uart_rhs_agent.seq);

    end
    phase.drop_objection(this);
  endtask
endclass

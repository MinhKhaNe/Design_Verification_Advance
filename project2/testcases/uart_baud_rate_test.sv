class uart_baud_rate_test extends uart_base_test;
  `uvm_component_utils(uart_baud_rate_test)

  uart_baud_rate_sequence  lhs_sequence;
  uart_baud_rate_sequence  rhs_sequence;

  int baud_rate_a[5] = '{4800, 9600, 19200, 57600, 115200};

  function new(string name = "uart_baud_rate_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    for(int i = 0; i < 5; i++) begin
      uart_lhs_config.randomize() with {data_width  == 5;
                          num_of_stop_bit == 1;
                          baud_rate == baud_rate_a[i];
                          parity_mode == uart_configuration::UART_PARITY_ODD;
                          };
      uart_rhs_config.randomize() with {data_width == 5;
                          num_of_stop_bit == 1;
                          baud_rate == baud_rate_a[i];
                          parity_mode == uart_configuration::UART_PARITY_ODD;
                          };
      uart_lhs_config.baud_rate_enable = 1'b1;
      uart_rhs_config.baud_rate_enable = 1'b1;
                          
      //`uvm_info(get_type_name(), $sformatf("UART_LHS_CONFIG info: %0s",uart_lhs_config.sprint()), UVM_LOW)
      //`uvm_info(get_type_name(), $sformatf("UART_RHS_CONFIG info: %0s",uart_rhs_config.sprint()), UVM_LOW)
      //uvm_config_db#(uart_configuration)

      lhs_sequence   = uart_baud_rate_sequence::type_id::create("lhs_sequence", this);
      rhs_sequence   = uart_baud_rate_sequence::type_id::create("rhs_sequence", this);

      lhs_sequence.start(env.uart_lhs_agent.seq);
      rhs_sequence.start(env.uart_rhs_agent.seq);
      
    end

    phase.drop_objection(this);
  endtask
endclass

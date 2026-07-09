class uart_random_test extends uart_base_test;
  `uvm_component_utils(uart_random_test)

  uart_random_sequence  lhs_sequence;
  uart_random_sequence  rhs_sequence;

  function new(string name = "uart_random_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  int baud_list[5] = '{4800, 9600, 19200, 57600, 115200};  

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    for(int pm = 0; pm < 3; pm++) begin
      for(int dw = 5; dw <= 9; dw++) begin
        for(int sb = 1; sb <=2; sb++) begin
          for(int br = 0; br < 5; br++) begin
            uart_lhs_config.randomize() with {data_width  == dw;
                          num_of_stop_bit == sb;
                          baud_rate == baud_list[br];
                          parity_mode == pm;
                         };
            uart_rhs_config.randomize() with {data_width == dw;
                          num_of_stop_bit == sb;
                          baud_rate == baud_list[br];
                          parity_mode == pm;
                          };
            //`uvm_info(get_type_name(), $sformatf("UART_LHS_CONFIG info: %0s",uart_lhs_config.sprint()), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf("UART_RHS_CONFIG info: %0s",uart_rhs_config.sprint()), UVM_LOW)
 
            lhs_sequence   = uart_random_sequence::type_id::create("lhs_sequence", this);
            rhs_sequence   = uart_random_sequence::type_id::create("rhs_sequence", this);

            lhs_sequence.start(env.uart_lhs_agent.seq);
            rhs_sequence.start(env.uart_rhs_agent.seq);
          end
        end
      end
    end
    phase.drop_objection(this);
  endtask
endclass

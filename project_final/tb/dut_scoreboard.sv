`uvm_analysis_imp_decl(_ahb)
`uvm_analysis_imp_decl(_uart)

class dut_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dut_scoreboard)

  uvm_analysis_imp_ahb  #(ahb_transaction, dut_scoreboard) ahb_a_export;
  uvm_analysis_imp_uart #(uart_transaction, dut_scoreboard) uart_a_export;

  uart_configuration  cfg;

  uart_transaction    expected_txd_q[$];
  uart_transaction    actual_txd_q[$];

  function new(string name = "dut_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahb_a_export  = new("ahb_a_export", this);
    uart_a_export = new("uart_a_export", this);

    if(!uvm_config_db#(uart_configuration)::get(this, "", "cfg", cfg))
      `uvm_fatal("CFG", "CANNOT get uart_configuration")
  endfunction

  virtual task run_phase(uvm_phase phase);

  endtask

  function void write_ahb(ahb_transaction trans);
    bit [7:0] data;
    uart_transaction exp;

    if((trans.xact_type == ahb_transaction::WRITE) && (trans.addr == 10'h018)) begin
      exp   = uart_transaction::type_id::create("exp");
      //Assign data
      data      = trans.data & ((1 << cfg.data_width) - 1);
      exp.data  = data;
      //Assign Parity
      if(cfg.parity_mode != uart_configuration::UART_PARITY_NONE) begin
        exp.parity  = parity_calculation(data);
      end
      //Assign stop bit
      exp.stop_bit  = cfg.num_of_stop_bit;
      //Push transaction to queue
      expected_txd_q.push_back(exp);      

      `uvm_info("SCOREBOARD", $sformatf("\n===== Captured data from AHB: 0x%0h",trans.data), UVM_LOW)
    end
    compare_txd();
  endfunction

  function void write_uart(uart_transaction trans);
    if((trans.direction == uart_transaction::RX)) begin
      actual_txd_q.push_back(trans);
      `uvm_info("SCOREBOARD", $sformatf("\n===== Captured data from UART: 0x%0h",trans.data), UVM_LOW)
    end
    compare_txd();
  endfunction

  function void compare_txd();
    uart_transaction act;
    uart_transaction exp;

    while((expected_txd_q.size() > 0) && (actual_txd_q.size() > 0)) begin
      act   = actual_txd_q.pop_front();
      exp   = expected_txd_q.pop_front();

      `uvm_info(get_type_name(), $sformatf("\n\n=====[UART TXD] Data comparison =====\n"), UVM_LOW)

      if(act.data != exp.data) begin
        `uvm_error(get_type_name(), $sformatf("\n===== FAILED!!! Expected value is 0x%0h, Actual data is 0x%0h =====",exp.data,act.data))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY!!! ====="), UVM_LOW)
      end

      `uvm_info(get_type_name(), $sformatf("\n\n=====[UART TXD] Parity comparison =====\n"), UVM_LOW)   

      if(act.parity != exp.parity) begin
        `uvm_error(get_type_name(), $sformatf("\n===== FAILED!!! Expected parity is %b, Actual parity is %b =====",exp.parity, act.parity))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY!!! ====="), UVM_LOW)
      end


    end
  endfunction

  function bit parity_calculation(bit [7:0] data);
    case(cfg.parity_mode)
      uart_configuration::UART_PARITY_NONE: return 0;
      uart_configuration::UART_PARITY_EVEN:  return ^(data);
      uart_configuration::UART_PARITY_ODD:   return ~(^data);
    endcase
  endfunction

endclass

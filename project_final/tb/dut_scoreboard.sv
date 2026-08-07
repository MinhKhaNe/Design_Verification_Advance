`uvm_analysis_imp_decl(_ahb)
`uvm_analysis_imp_decl(_uart)
`uvm_analysis_imp_decl(_interrupt)

class dut_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dut_scoreboard)

  uvm_analysis_imp_ahb        #(ahb_transaction, dut_scoreboard) ahb_a_export;
  uvm_analysis_imp_uart       #(uart_transaction, dut_scoreboard) uart_a_export;
  uvm_analysis_imp_interrupt  #(interrupt_transaction, dut_scoreboard) interrupt_a_export;

  uart_configuration  cfg;

  uart_transaction    expected_txd_q[$];
  uart_transaction    actual_txd_q[$];

  int         data_width;
  int         stop_bit;
  bit [1:0]   parity_mode;
  bit         check_interrupt_empty, check_interrupt_full;
  bit [31:0]  int_status;

  typedef enum{
    INT_IDLE,
    INT_ASSERT,
    INT_DEASSERT
  } int_state_e;

  int_state_e int_state = INT_IDLE;

  function new(string name = "dut_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    $display("ENTER SCOREBOARD BUILD PHASE");  

    ahb_a_export  = new("ahb_a_export", this);
    uart_a_export = new("uart_a_export", this);
    interrupt_a_export = new("interrupt_a_export", this);

    if(!uvm_config_db#(uart_configuration)::get(this, "", "cfg", cfg))
      `uvm_fatal("CFG", "CANNOT get uart_configuration")
    //else
    //  `uvm_info("CFG", "GET SUCCESSFULLY!!!!", UVM_NONE)

    //`uvm_info(get_type_name(), $sformatf("%s",cfg.sprint()), UVM_NONE)
  endfunction

  virtual task run_phase(uvm_phase phase);

  endtask

  function void write_ahb(ahb_transaction trans);
    bit [7:0]   data;
    bit [31:0]  lcr;
    uart_transaction exp;

    if((trans.xact_type == ahb_transaction::WRITE) && (trans.addr == 10'h00C)) begin
      lcr = trans.data;
      if(lcr[3] == 1'b0) begin
        parity_mode = 2'b00;  //NONE
      end
      else begin
        parity_mode = lcr[4] ? 2'b10 : 2'b01; //EVEN : ODD
      end

      case(lcr[1:0])
        2'b11: data_width = 8;
        2'b10: data_width = 7;
        2'b01: data_width = 6;
        2'b00: data_width = 5;
      endcase

      stop_bit = lcr[2] ? 2 : 1;
    end

    if((trans.xact_type == ahb_transaction::WRITE) && (trans.addr == 10'h018)) begin
      exp   = uart_transaction::type_id::create("exp");
      //Assign data
      data      = trans.data & ((1 << data_width) - 1);
      exp.data  = data;
      //Assign Parity
      exp.parity  = parity_calculation(data, parity_mode);
      //Assign stop bit
      exp.stop_bit  = stop_bit;
      //Push transaction to queue
      expected_txd_q.push_back(exp);      

      `uvm_info("SCOREBOARD", $sformatf("\n===== Captured data from AHB: 0x%0h",trans.data), UVM_LOW)
    end
    
    if((trans.xact_type == ahb_transaction::WRITE) && (trans.addr == 10'h010)) begin
      int_status = trans.data;
      $display("===== Received Data from IER =====");
      if((int_status[3] == 1) || (int_status[1] == 1)) begin
        check_interrupt_empty = 1;
        int_state = INT_ASSERT;
      end
      else if((int_status[2] == 1) || (int_status[0] == 1)) begin
        check_interrupt_full = 1;
      end
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
      //`uvm_info(get_type_name(), $sformatf("%s", act.sprint()), UVM_LOW)
      //`uvm_info(get_type_name(), $sformatf("%s", exp.sprint()), UVM_LOW)

      if(act.data != exp.data) begin
        `uvm_error(get_type_name(), $sformatf("\n=====[DATA FRAME: %0d] FAILED!!! Expected value is 0x%0h, Actual data is 0x%0h =====",data_width, exp.data,act.data))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n=====[DATA FRAME: %0d] PASSED SUCCESSFULLY!!! =====", data_width), UVM_LOW)
      end

      `uvm_info(get_type_name(), $sformatf("\n\n=====[UART TXD] Parity comparison =====\n"), UVM_LOW)   

      if(act.parity != exp.parity) begin
        `uvm_error(get_type_name(), $sformatf("\n=====[PARITY MODE: %0b] FAILED!!! Expected parity is %b, Actual parity is %b =====",parity_mode, exp.parity, act.parity))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n=====[PARITY MODE: %0b] PASSED SUCCESSFULLY!!! =====", parity_mode), UVM_LOW)
      end


    end
  endfunction

  function bit parity_calculation(bit [7:0] data, bit [1:0] parity_mode);
    case(parity_mode)
      2'b00: return 0;
      2'b10:  return ^(data);
      2'b01:   return ~(^data);
    endcase
  endfunction

  function void write_interrupt(interrupt_transaction trans);
    case(int_state)
      INT_ASSERT: begin
        if(trans.interrupt) begin
          `uvm_info(get_type_name(), $sformatf("===== Interrupt is asserted ====="), UVM_LOW)
          int_state = INT_DEASSERT;
        end
        else begin
          `uvm_error(get_type_name(), $sformatf("===== Interrupt should be asserted ====="))
        end
      end
      INT_DEASSERT: begin
        if(!trans.interrupt) begin
          `uvm_info(get_type_name(), $sformatf("===== PASSED SUCCESSFULLY!!! ====="), UVM_LOW)
          int_state = INT_IDLE;
        end
        else begin
          `uvm_error(get_type_name(), $sformatf("===== FAILED!!! Interrupt should be deasserted ====="))
        end
      end
    endcase
  endfunction

endclass

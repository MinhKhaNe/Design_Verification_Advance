`uvm_analysis_imp_decl(_rhs_drv)
`uvm_analysis_imp_decl(_lhs_drv)
`uvm_analysis_imp_decl(_lhs_mon)

class uart_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(uart_scoreboard)

  uvm_analysis_imp_rhs_drv #(uart_transaction, uart_scoreboard)  uart_rhs_driver_export;
  uvm_analysis_imp_lhs_mon #(uart_transaction, uart_scoreboard)  uart_lhs_monitor_export;
  uvm_analysis_imp_lhs_drv #(uart_transaction, uart_scoreboard)  uart_lhs_driver_export;

  uart_transaction  lhs_tx_act_q[$];
  uart_transaction  lhs_rx_act_q[$];
  uart_transaction  rhs_exp_q[$];
  uart_transaction  lhs_exp_q[$];

  function new(string name = "uart_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uart_rhs_driver_export    = new("uart_rhs_driver_export", this);
    uart_lhs_driver_export    = new("uart_lhs_driver_export", this);
    uart_lhs_monitor_export   = new("uart_lhs_monitor_export", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    
  endtask

  function void write_rhs_drv(uart_transaction trans);
    rhs_exp_q.push_back(trans);
    //`uvm_info(get_type_name(), $sformatf("RHS DRV COUNT = %0d", rhs_exp_q.size()), UVM_LOW)
    compare_rx();
    compare_tx();
  endfunction

  function void write_lhs_mon(uart_transaction trans);
    if(trans.direction == uart_transaction::TX) begin
      lhs_tx_act_q.push_back(trans);
    end
    else begin 
      lhs_rx_act_q.push_back(trans);
    end
    //`uvm_info(get_type_name(), $sformatf("LHS MON COUNT = %0d",lhs_act_q.size()), UVM_LOW)
    compare_tx();
    compare_rx();
  endfunction

  function void write_lhs_drv(uart_transaction trans);
    lhs_exp_q.push_back(trans);
    compare_rx();
    compare_tx();
  endfunction


  function void compare_rx();
   
    uart_transaction act;
    uart_transaction exp;

    //`uvm_info(get_type_name(), ("Compare rx signals"), UVM_LOW)
    
    while((rhs_exp_q.size() > 0) && (lhs_rx_act_q.size() > 0)) begin
      act   = lhs_rx_act_q.pop_front();
      exp   = rhs_exp_q.pop_front();

      `uvm_info(get_type_name(), $sformatf("\n\n=====[RHS & LHS] DATA COMPARISON =====\n"), UVM_LOW)
      if(act.data != exp.data) begin
        `uvm_error(get_type_name(), $sformatf("\n===== FAILED !!! Expected value is %0s, Actual value is %0s =====",exp.parity, act.parity))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY !!! Expected value is %h, Actual value is %h =====", exp.data, act.data), UVM_LOW)
      end

      `uvm_info(get_type_name(), $sformatf("\n\n=====[RHS & LHS] PARITY COMPARISON =====\n"), UVM_LOW)
      if(act.parity != exp.parity) begin
          `uvm_error(get_type_name(), $sformatf("\n===== FAILED !!! Expected value is %b, Actual value is %b =====",exp.parity, act.parity))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY !!! Expected value is %b, Actual value is %b =====", exp.parity, act.parity), UVM_LOW)
      end

//      `uvm_info(get_type_name(), $sformatf("\n\n===== STOP BITS COMPARISON =====\n"), UVM_LOW)
//      if(act.stop_bit != exp.stop_bit) begin
//          `uvm_error(get_type_name(), $sformatf("\n===== FAILED !!! Expected value is %h, Actual value is %h =====",exp.stop_bit, act.stop_bit))
//      end
//      else begin
//        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY !!! Expected value is %h, Actual value is %h =====", exp.stop_bit, act.stop_bit), UVM_LOW)
//      end

    end

  endfunction

  function void compare_tx();
    
    uart_transaction act;
    uart_transaction exp;
  
    //`uvm_info(get_type_name(), ("Compare tx signals"), UVM_LOW)
   
    while((lhs_exp_q.size() > 0) && (lhs_tx_act_q.size() > 0)) begin
      act   = lhs_tx_act_q.pop_front();
      exp   = lhs_exp_q.pop_front();

      `uvm_info(get_type_name(), $sformatf("\n\n=====[LHS Only] DATA COMPARISON =====\n"), UVM_LOW)
      if(act.data != exp.data) begin
        `uvm_error(get_type_name(), $sformatf("\n===== FAILED !!! Expected value is %0s, Actual value is %0s =====",exp.parity, act.parity))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY !!! Expected value is %h, Actual value is %h =====", exp.data, act.data), UVM_LOW)
      end

      `uvm_info(get_type_name(), $sformatf("\n\n=====[LHS Only] PARITY COMPARISON =====\n"), UVM_LOW)
      if(act.parity != exp.parity) begin
          `uvm_error(get_type_name(), $sformatf("\n===== FAILED !!! Expected value is %b, Actual value is %b =====",exp.parity, act.parity))
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY !!! Expected value is %b, Actual value is %b =====", exp.parity, act.parity), UVM_LOW)
      end

//      `uvm_info(get_type_name(), $sformatf("\n\n===== STOP BITS COMPARISON =====\n"), UVM_LOW)
//      if(act.stop_bit != exp.stop_bit) begin
//          `uvm_error(get_type_name(), $sformatf("\n===== FAILED !!! Expected value is %h, Actual value is %h =====",exp.stop_bit, act.stop_bit))
//      end
//      else begin
//        `uvm_info(get_type_name(), $sformatf("\n===== PASSED SUCCESSFULLY !!! Expected value is %h, Actual value is %h =====", exp.stop_bit, act.stop_bit), UVM_LOW)
//      end

    end

  endfunction


endclass

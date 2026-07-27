`uvm_analysis_imp_decl(_ahb)
`uvm_analysis_imp_decl(_uart)

class dut_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dut_scoreboard)

  uvm_analysis_imp_ahb  #(ahb_transaction, dut_scoreboard) ahb_a_export;
  uvm_analysis_imp_uart #(uart_transaction, dut_scoreboard) uart_a_export;

  function new(string name = "dut_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ahb_a_export  = new("ahb_a_export", this);
    uart_a_export = new("uart_a_export", this);
  endfunction

  virtual task run_phase(uvm_phase phase);

  endtask

  function void write_ahb(ahb_transaction trans);

  endfunction

  function void write_uart(uart_transaction trans);

  endfunction

endclass

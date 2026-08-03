package test_pkg;
  import uvm_pkg::*;
  import ahb_pkg::*;
  import env_pkg::*;
  import seq_pkg::*;
  import uart_pkg::*;
  import uart_regmodel_pkg::*;

  `include "base_test.sv"
  `include "reg_test.sv"
  `include "uart_txd_x16_parity.sv"
  `include "uart_txd_x16_data_frame.sv"
  `include "uart_txd_x16_stop_bit.sv"
  `include "uart_txd_x16_baud_rate.sv"
  `include "uart_txd_x16_random.sv"

endpackage

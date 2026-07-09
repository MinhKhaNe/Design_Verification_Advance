//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : test_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_TEST_PKG__SV
`define GUARD_UART_TEST_PKG__SV

package test_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;
  import seq_pkg::*;
  import env_pkg::*;

  // Include your file
  `include "uart_base_test.sv"
  `include "uart_parity_test.sv"
  `include "uart_data_frame_test.sv"
  `include "uart_stop_bit_test.sv"
  `include "uart_baud_rate_test.sv"
  `include "uart_random_test.sv"

endpackage: test_pkg

`endif



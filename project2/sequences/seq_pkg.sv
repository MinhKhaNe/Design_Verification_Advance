//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : seq_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_SEQ_PKG__SV
`define GUARD_UART_SEQ_PKG__SV

package seq_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;

  // Include your file
  `include "uart_parity_sequence.sv"
  `include "uart_data_frame_sequence.sv"
  `include "uart_stop_bit_sequence.sv"
  `include "uart_baud_rate_sequence.sv"
  `include "uart_random_sequence.sv"  
  `include "uart_parity_rx_sequence.sv"
  `include "uart_parity_tx_sequence.sv"
endpackage: seq_pkg

`endif



package seq_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;
  import ahb_pkg::*;
  import uart_regmodel_pkg::*;

  `include "default_value_chk_sequence.sv"
  `include "read_write_chk_sequence.sv"
  `include "access_reserved_chk_sequence.sv"
  `include "parity_x16_chk_sequence.sv"
  `include "data_frame_x16_chk_sequence.sv"
  `include "stop_bit_x16_chk_sequence.sv"
  `include "baud_rate_x16_chk_sequence.sv"
  `include "random_x16_chk_sequence.sv"

endpackage

//=============================================================================
// Project       : APB VIP
//=============================================================================
// Filename      : apb_if.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 13-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_APB_IF__SV
`define GUARD_APB_IF__SV

interface apb_if();

  logic                        pclk;  
  logic                        presetn;  
  logic [`APB_ADDR_WIDTH-1:0]  paddr;  
  logic                        pwrite; 
  logic [`APB_PSEL_WIDTH-1:0]  psel;   
  logic                        penable;
  logic [`APB_DATA_WIDTH-1:0]  pwdata; 
  logic                        pready; 
  logic [`APB_DATA_WIDTH-1:0]  prdata; 
  logic                        pslverr;

endinterface

`endif



interface timer_interface();

  logic           ker_clk;
  logic           pclk;
  logic           presetn;
  logic   [7:0]   paddr;
  logic           psel;
  logic           penable;
  logic           pwrite;
  logic   [7:0]   pwdata;
  logic           pready;
  logic   [7:0]   prdata;
  logic           interrupt;

endinterface

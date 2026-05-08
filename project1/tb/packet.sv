class packet;
 
  rand  bit           pclk, presetn;
  rand  bit   [7:0]   paddr;
  rand  bit           psel, pwrite, penable;
  rand  bit   [7:0]   pwdata;
        bit   [7:0]   prdata;
        bit           pready, intr;

  function new();
  endfunction

  constraint valid_addr {
    paddr inside {[8'h00 : 8'h03]};
  }

  constraint valid_data_by_addr {
    paddr == 8'h00 -> pwdata inside {[8'b0000_0000 : 8'b0001_1111]};
    paddr == 8'h01 -> pwdata inside {[8'b0000_0000 : 8'b0000_0011]};
    paddr == 8'h03 -> pwdata inside {[8'b0000_0000 : 8'b0000_0011]};
  }
 
endclass

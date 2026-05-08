class packet;
  //tracnsaction info
  typedef enum {READ, WRITE} APB_type;
        bit   [7:0]   paddr;
  randc bit   [7:0]   data;
        bit           intr;
  APB_type trans_type;

  function new();
  endfunction

endclass

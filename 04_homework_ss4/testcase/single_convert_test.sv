class single_convert_test extends base_test;

 function new();
  super.new(1);
 endfunction

 virtual task start();
  $display("\n===== Single converter is called =====\n");
 endtask

endclass

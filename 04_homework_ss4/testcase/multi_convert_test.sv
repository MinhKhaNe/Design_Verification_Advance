class multi_convert_test extends base_test;

 function new();
  super.new(3);
 endfunction

 virtual task start();
  $display("\n===== Multi converter is called =====\n");
 endtask

endclass

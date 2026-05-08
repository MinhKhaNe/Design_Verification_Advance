import converter_pkg::*;

class base_test;
 //import converter_pkg::*;

 environment env;
 virtual dut_if dut;
 int num;

 function new(int num = 1);
  this.num = num;
 endfunction

 function void build();
  env = new(num);
  env.dut = dut;
  $display("[Base test] Start Build");
 endfunction 

 virtual task start();

 endtask

 task display_test();
  build();
  fork
   env.connect();
   start();
   env.run();
  join_any
  #2000;
  $display("[Base test] END STIMULATION");
 endtask

endclass

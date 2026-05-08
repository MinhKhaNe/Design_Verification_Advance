class count_up_test extends base_test;
  
  virtual task run_scenario();
    bit [7:0] data_1, data_2;
    write(8'h00, 8'h00);   //reset
    write(8'h01, 8'h00);   //start write from 0
    write(8'h00, 8'h01);   //Start count up

    read(8'h01,data_1);
    read(8'h00,data_2);
  endtask

endclass

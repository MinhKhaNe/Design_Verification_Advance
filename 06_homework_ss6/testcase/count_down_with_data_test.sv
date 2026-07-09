class count_down_with_data_test extends base_test;
  
  virtual task run_scenario();
    bit [7:0] data_1, data_2;

    write(8'h00, 8'h00);   //reset
    write(8'h01, 8'd100);   //start write from 0
    write(8'h00, 8'h03);   //Start count up

    //repeat (257) begin
    //  @(posedge dut_vif.pclk);
    read(8'h01, data_1);
    read(8'h00, data_2);
    //  $display("===== Data of counter is: %d =====",data);
    //end
  endtask

endclass

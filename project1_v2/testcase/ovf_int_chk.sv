class ovf_int_chk extends base_test;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    bit [7:0] data;
    $display("\n===== t=%0t Case 6.1 Overflow status check =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h03, 8'h01);  //Write overflow_en
    write(8'h00, 8'h01);  //Start count up
    repeat (64) @(posedge dut.pclk); //256 ker_clk
    read(8'h01, data);
    //compare(8'h02, data);
    if(data != 8'h01) begin
      $display("\n===== t=%0t FAILED!!! Overflow of TSR is not turned on =====\n",$time);
    end
    else begin
      $display("\n===== t=%0t PASSED SUCCESSFULLY!!! Overflow of TSR is turned on =====\n",$time);
    end
    
    @(posedge dut.pclk);
    #1;
    if(dut.interrupt) begin
      $display("\n===== t=%0t Interrupt is caught successfully =====\n",$time);
    end
    else begin
      $display("\n===== t=%0t Interrupt is not turn on =====\n",$time);
    end
  
    $display("\n===== t=%0t Case 6.2 Clear overflow stauts of TSR =====\n",$time);
    write(8'h01, 8'h02);  //Clear TSR with wrong value
    read(8'h01, data);
    compare(8'h01, data);
    write(8'h01, 8'h01);
    read(8'h01, data);
    compare(8'h00, data);
  endtask

endclass

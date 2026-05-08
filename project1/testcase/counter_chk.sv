class counter_chk extends base_test;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    bit [7:0] data;
    time T1, T2;
    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 4.1 Start count up =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00,8'h01);
    T1 = $time;
    write(8'h03, 8'h01);
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b00);

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 4.2 Start count down =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'h02);
    write(8'h00, 8'h03);
    T1 = $time;
    write(8'h03, 8'h02);
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b00);
    
    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 4.3 Load data and count up =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h02, 8'h64);
    write(8'h00, 8'b0000_0100);
    write(8'h00, 8'b0000_0001);
    T1 = $time;
    write(8'h03, 8'h01);
    wait(dut.interrupt);
    T2 = $time;
    if(((T2-T1) > 156*5ns + 7*5ns) || ((T2-T1) < 156*5ns - 7*5ns)) begin
      $display("\n===== t=%0t FAILED !!! Expecting timing is %0t, Actual timing is %0t =====\n",$time,156*5ns,(T2-T1));
    end
    else begin
      $display("\n===== t=%0t PASSED SUCCESSFULLY !!! Expecting timing is %0t, Actual timing is %0t =====\n",$time,156*5ns,(T2-T1));
    end

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 4.4 Load data and count down =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h02, 8'd100);
    write(8'h00, 8'b0000_0110);
    write(8'h00, 8'b0000_0011);
    T1 = $time;
    write(8'h03, 8'h02);
    wait(dut.interrupt);
    T2 = $time;
    if(((T2-T1) > 100*5ns + 7*5ns) || ((T2-T1) < 100*5ns - 7*5ns)) begin
      $display("\n===== t=%0t FAILED !!! Expecting timing is %0t, Actual timing is %0t =====\n",$time,100*5ns,(T2-T1));
    end
    else begin
      $display("\n===== t=%0t PASSED SUCCESSFULLY !!! Expecting timing is %0t, Actual timing is %0t =====\n",$time,100*5ns,(T2-T1));
    end

  endtask

endclass

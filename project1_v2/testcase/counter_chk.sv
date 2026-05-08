class counter_chk extends base_test;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    bit [7:0] data;
    //pkt = new();
    time T1, T2;
    T2 = 0; T1 = 0;

    $display("\n===== t=%0t Case 4.1 Start count up =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'h01);
    T1 = $time;
    write(8'h03, 8'h01);
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b00);
    
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
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);      
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      #1;
      dut.presetn = 1'b1; 
      write(8'h03, 8'h01);  //Write interrupt enable
      write_rand(8'h02);    //Write random value to TDR
      write(8'h00, 8'h04);  //Load data to counter
      write(8'h00, 8'h01);  //Start Timer
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_up(T1, T2, 2'b00);
    end

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 4.4 Load data and count down =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);      
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      #1;
      dut.presetn = 1'b1; 
      write(8'h03, 8'h02);  //Write interrupt enable
      write_rand(8'h02);    //Write random value to TDR
      write(8'h00, 8'h06);  //Load data to counter
      write(8'h00, 8'h03);  //Start Timer
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_down(T1, T2, 2'b00);
    end


  endtask

endclass

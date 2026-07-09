class clk_div extends base_test;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    bit [7:0] data;
    time T1, T2;
    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.1 No divide with count up =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h01);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'h04);
      write(8'h00, 8'h01);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_up(T1, T2, 2'b00);
    end 

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.2 Divide by 2 with count up =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h01);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'b0000_1100);
      write(8'h00, 8'b0000_1001);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_up(T1, T2, 2'b01);
    end 
   
    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.3 Divide by 4 with count up =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h01);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'b0001_0100);
      write(8'h00, 8'b0001_0001);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_up(T1, T2, 2'b10);
    end 


    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.4 Divide by 8 with count up =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h01);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'b0001_1100);
      write(8'h00, 8'b0001_1001);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_up(T1, T2, 2'b11);
    end 


    //////////////////////////////
    // COUNT DOWN WITH CLK_DIV //
    /////////////////////////////
    
    $display("\n===== t=%0t Case 3.5 No divide with count down =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h02);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'h06);
      write(8'h00, 8'h03);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_down(T1, T2, 2'b00);
    end 

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.6 Divide by 2 with count down =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h02);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'b0000_1110);
      write(8'h00, 8'b0000_1011);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_down(T1, T2, 2'b01);
    end 
   
    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.7 Divide by 4 with count down =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h02);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'b0001_0110);
      write(8'h00, 8'b0001_0011);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_down(T1, T2, 2'b10);
    end 


    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.8 Divide by 8 with count down =====\n",$time);
    for(int i = 0; i < 255; i++) begin
      @(posedge dut.pclk);
      dut.presetn = 1'b0;
      @(posedge dut.pclk);
      dut.presetn = 1'b1;
      write(8'h03, 8'h02);  //Write interrupt enable
      write_rand(8'h02);
      write(8'h00, 8'b0001_1110);
      write(8'h00, 8'b0001_1011);
      T1 = $time;
      wait(dut.interrupt);
      T2 = $time;
      compare_timing_random_down(T1, T2, 2'b11);
    end 


    endtask

endclass

class clk_div extends base_test;

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    bit [7:0] data;
    time T1, T2;
    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.1 No divide with count up =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'h01);  //Write 8'h00 to TCR
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h01);  //write overflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b00);

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.2 Divide by 2 with count up =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'b0000_1000);   //Setup clk_div
    write(8'h00, 8'b0000_1001);   //Start counting
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h01);  //write overflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b01);

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.3 Divide by 4 with count up =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'b0001_0000);   //Setup
    write(8'h00, 8'b0001_0001);  //Write 8'h00 to TCR
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h01);  //write overflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b10);

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.4 Divide by 8 with count up =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'b0001_1000);
    write(8'h00, 8'b0001_1001);  //Write 8'h00 to TCR
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h01);  //write overflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b11);
    //////////////////////////////
    // COUNT DOWN WITH CLK_DIV //
    /////////////////////////////
    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.5 No divide with count down =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'h02);
    write(8'h00, 8'h03);  //Write 8'h00 to TCR
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h02);  //write underflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b00);

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.6 Divide by 2 with count down =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'b0000_1010);   //Setup clk_div
    write(8'h00, 8'b0000_1011);   //Start counting
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h02);  //write overflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b01);

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.7 Divide by 4 with count down =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'b0001_0010);   //Setup
    write(8'h00, 8'b0001_0011);  //Write 8'h00 to TCR
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h02);  //write overflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b10);

    T2 = 0; T1 = 0;
    $display("\n===== t=%0t Case 3.8 Divide by 8 with count down =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    write(8'h00, 8'b0001_1010);
    write(8'h00, 8'b0001_1011);  //Write 8'h00 to TCR
    T1 = $time;
    /*repeat (64) begin 
      @(posedge dut.pclk);
      #1;
      read(8'h01, data);
      if((data == 8'h01) && (T2 == 0)) begin
        T2 = $time;
        $display("===== t=%0t T2 is valid =====",$time);
        break;
      end
    end*/
    write(8'h03, 8'h02);  //write overflow_en
    wait(dut.interrupt);
    T2 = $time;
    compare_timing(T1, T2, 2'b11);

  endtask

endclass

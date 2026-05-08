class base_test;

  environment env;
  virtual dut_if dut;

  function new();
  endfunction

  function void build();
    env = new(dut);
  endfunction

  task write(bit [7:0] paddr, bit [7:0] pwdata);
    packet pkt  = new();
    pkt.paddr   = paddr;
    pkt.pwdata  = pwdata;
    pkt.pwrite  = 1'b1;
    pkt.psel    = 1'b1;
    env.stim.send_pkt(pkt);
    @(env.drv.xfer_done);
    $display("[Base] Write finished! Write Data %h at Address %h",pwdata, paddr);
  endtask

  task read(bit [7:0] paddr,ref bit [7:0] prdata);
    packet pkt  = new();
    pkt.paddr   = paddr;
    pkt.pwrite  = 1'b0;
    pkt.psel    = 1'b1;
    env.stim.send_pkt(pkt);
    @(env.drv.xfer_done);
    prdata      = pkt.prdata; 
    $display("[Base] t=%0t  Read finished! At Address %h, Data is %h",$time, paddr, prdata);
  endtask

  task compare(bit [7:0] expected, bit [7:0] actual);
    if(expected != actual) begin
      $display("\n===== t=%0t FAILED!!! Value mismatch, Expected value is %h, Actual value is %h =====\n",$time, expected, actual);
    end
    else begin
      $display("\n===== t=%0t PASSED SUCCESSFULLY!!!! Expected value is %h, Actual value is %h =====\n",$time, expected, actual);
    end
  endtask

  task compare_timing(time T1, time T2, bit [1:0] clk_div);
    //Error timing ~ 7 clk
    if(clk_div == 2'b00) begin
      time actual = T2 - T1;
      time ideal = 256*5ns;

      if((actual > ideal + 7*5ns) || (actual < ideal - 7*5ns)) begin
        $display("\n===== t=%0t FAILED !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end
      else begin
        $display("\n===== t=%0t PASSED SUCCESSFULLY !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end
    end
    else if(clk_div == 2'b01) begin
      time ideal = 256*2*5ns;
      time actual = T2 - T1;

      if((actual > ideal + 7*10ns) || (actual < ideal - 7*10ns)) begin
        $display("\n===== t=%0t FAILED !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end
      else begin
        $display("\n===== t=%0t PASSED SUCCESSFULLY !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end

    end
    else if(clk_div == 2'b10) begin
      time ideal = 256*4*5ns;
      time actual = T2-T1;
      if((actual > ideal + 7*20ns) || (actual < ideal - 7*20ns)) begin
        $display("\n===== t=%0t FAILED !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end
      else begin
        $display("\n===== t=%0t PASSED SUCCESSFULLY !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end
    end
    else if(clk_div == 2'b11) begin
      time ideal = 256*8*5ns;
      time actual = T2 - T1;
      if((actual > ideal + 7*40ns) || (actual < ideal - 7*40ns)) begin
        $display("\n===== t=%0t FAILED !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end
      else begin
        $display("\n===== t=%0t PASSED SUCCESSFULLY !!! Expected timing is %0t, Actual timing is %0t =====\n",$time,ideal,(T2-T1));
      end
    end
  endtask

  //Override task
  virtual task run_scenario();
  endtask

  task run();
    build();
    fork
      env.run();
      run_scenario();
    join_any
    #1us;
    $display("[Base] End simulation");
    $finish;
  endtask

endclass

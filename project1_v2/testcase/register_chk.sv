class register_chk extends base_test;

  bit [7:0] addr_q[$];

  function new();
    super.new();
  endfunction

  virtual task run_scenario();
    bit [7:0] data;
    $display("\n===== t=%0t Case 2.1 Read default value =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    read(8'h00, data);
    compare(8'h00, data);
    read(8'h01, data);
    compare(8'h00, data);
    read(8'h02, data);
    compare(8'h00, data);
    read(8'h03, data);
    compare(8'h00, data);

    $display("\n===== t=%0t Case 2.2 Read and Write value check =====\n",$time);
    write(8'h00, 8'b0001_1110);   //Turn off timer_en
    write(8'h01, 8'hFF);
    write(8'h02, 8'hFF);
    write(8'h03, 8'hFF);
    read(8'h00, data);
    compare(8'b0001_1110, data);
    read(8'h01, data);
    compare(8'b0000_0000, data);
    read(8'h02, data);
    compare(8'hFF, data);
    read(8'h03, data);
    compare(8'b0000_0011, data);

    $display("\n===== t=%0t Case 2.3 Reset on the fly check =====\n",$time);
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b0;
    read(8'h00, data);
    compare(8'h00, data);
    read(8'h01, data);
    compare(8'h00, data);
    read(8'h02, data);
    compare(8'h00, data);
    read(8'h03, data);
    compare(8'h00, data);
    
    $display("\n===== t=%0t Case 2.4 Write and Read invalid Addresses =====\n",$time);
    dut.presetn = 1'b0;
    @(posedge dut.pclk);
    #1;
    dut.presetn = 1'b1;
    for(int i = 0; i < 10; i++) begin
      bit [7:0] address_rand = $urandom_range(4,255);
      write(address_rand , 8'hFF);
      addr_q.push_back(address_rand);
    end
    for(int i = 0; i < 10; i++) begin
      bit [7:0] address_rand = addr_q.pop_front();
      read(address_rand , data);
      compare(8'h00, data);
    end

  endtask

endclass

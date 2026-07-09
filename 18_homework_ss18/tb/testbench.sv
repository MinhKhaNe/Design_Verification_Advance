module testbench;
  import uvm_pkg::*;
  import test_pkg::*;

  ahb_if ahb_vif();

  uart_top u_dut(
                 .HCLK(ahb_vif.HCLK), 
                 .HRESETN(ahb_vif.HRESETn),
                 .HADDR(ahb_vif.HADDR), 
                 .HBURST(ahb_vif.HBURST), 
                 .HTRANS(ahb_vif.HTRANS), 
                 .HSIZE(ahb_vif.HSIZE), 
                 .HPROT(ahb_vif.HPROT), 
                 .HWRITE(ahb_vif.HWRITE), 
                 .HWDATA(ahb_vif.HWDATA),
                 .HSEL(ahb_vif.HSEL),
                 .HREADYOUT(ahb_vif.HREADYOUT), 
                 .HRDATA(ahb_vif.HRDATA), 
                 .HRESP(ahb_vif.HRESP));

  assign ahb_vif.HSEL = 1'b1;

  initial begin
    ahb_vif.HRESETn = 0;
    #100ns ahb_vif.HRESETn = 1;
  end

  // 50 MHz
  initial begin
    ahb_vif.HCLK = 0;
    forever begin 
      #10ns;
      ahb_vif.HCLK = ~ahb_vif.HCLK;
    end
  end

  initial begin
    /** Set interface to driver to control - Learn in next session*/
    uvm_config_db#(virtual ahb_if)::set(null,"*","ahb_vif",ahb_vif);
    /** Start the UVM test */
    run_test();
    

  end

endmodule


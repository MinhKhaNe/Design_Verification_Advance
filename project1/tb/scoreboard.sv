class scoreboard;

  mailbox #(packet) m2s_mb;
  packet pkt;

  covergroup APB_GROUP;
    apb_transfer: coverpoint pkt.pwrite{
      bins apb_read   = {1'b0};
      bins apb_write  = {1'b1};
    }

    apb_select: coverpoint pkt.psel {
      bins selected     = {1'b1};
      bins not_selected = {1'b0};
    }

    apb_address: coverpoint pkt.paddr{
      bins TCR  = {8'h00};
      bins TSR  = {8'h01};
      bins TDR  = {8'h02};
      bins TIE  = {8'h03};
      bins reserved = {[8'h04:8'hFF]};
    }

    apb_data: coverpoint pkt.pwdata iff (pkt.pwrite && pkt.psel){
      bins TCR_range[] = {[8'h00:8'h1F]};
      bins TSR_range[] = {[8'h00:8'h02]};
      bins TDR_value   = {[8'h00:8'hFF]};
      bins TIE_range[] = {[8'h00:8'h02]};
    }

    cross apb_address, apb_data, apb_transfer, apb_select{
      bins write_TCR  = binsof(apb_address.TCR) && binsof(apb_data.TCR_range) && binsof(apb_transfer.apb_write) && binsof(apb_select.selected);
      bins write      = binsof(apb_transfer.apb_write) && binsof(apb_select.selected);
      bins read       = binsof(apb_transfer.apb_read) && binsof(apb_select.selected);
      bins write_TDR  = binsof(apb_address.TDR) && binsof(apb_data.TDR_value) && binsof(apb_transfer.apb_write) && binsof(apb_select.selected);
      bins write_TSR  = binsof(apb_address.TSR) && binsof(apb_data.TSR_range) && binsof(apb_transfer.apb_write) && binsof(apb_select.selected);
      bins write_TIE  = binsof(apb_address.TIE) && binsof(apb_data.TIE_range) && binsof(apb_transfer.apb_write) && binsof(apb_select.selected);
      bins write_invalid = binsof(apb_address.reserved) && binsof(apb_data.TDR_value) && binsof(apb_transfer.apb_write) && binsof(apb_select.selected); 
    }

  endgroup

  function new(mailbox #(packet) m2s_mb);
    this.m2s_mb = m2s_mb;
    APB_GROUP = new();
  endfunction

  task run();
    while(1) begin
      pkt = new();
      m2s_mb.get(pkt);
      APB_GROUP.sample();
      $display("[Scoreboard] Get packet from Monitor: Address: %h, Data: %h",pkt.paddr,pkt.prdata);
    end
  endtask

endclass

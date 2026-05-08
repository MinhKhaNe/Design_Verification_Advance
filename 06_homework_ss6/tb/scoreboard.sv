class scoreboard;
  mailbox #(packet) m2s_mb;
  packet pkt;
  
  covergroup APB_GROUP;
    apb_transfer: coverpoint pkt.transfer{
      bins apb_read   = {packet::READ};
      bins apb_write  = {packet::WRITE};
    }

    apb_address: coverpoint pkt.addr{
      bins CCR_addr       = {2'b00};
      bins CDR_addr       = {2'b01};
      ignore_bins others  = {2'b10,2'b11};
    }

    apb_data: coverpoint pkt.data {
      bins count_up   = {2'b01} iff (pkt.addr == 2'b00 && pkt.transfer == packet::WRITE);
      bins count_down = {2'b11} iff (pkt.addr == 2'b00 && pkt.transfer == packet::WRITE);
      bins data_value = {[0:255]} iff (pkt.addr == 2'b01 && pkt.transfer == packet::WRITE);
    }

    apb_transaction: cross apb_address,apb_transfer;

    counter_up_feature: cross apb_address,apb_data,apb_transfer{
      //bins write_CCR_count_up   = binsof(apb_address.CCR_addr) && binsof(apb_transfer.apb_write) && binsof(apb_data.count_up);
      ignore_bins counter_up    = !binsof(apb_address.CCR_addr) || !binsof(apb_transfer.apb_write) || !binsof(apb_data.count_up);
    }

    counter_down_feature: cross apb_address,apb_data,apb_transfer{
      //bins write_CCR_count_down  = binsof(apb_address.CCR_addr) && binsof(apb_transfer.apb_write) && binsof(apb_data.count_down);
      ignore_bins counter_down    = !binsof(apb_address.CCR_addr) || !binsof(apb_transfer.apb_write) || !binsof(apb_data.count_down);
    }

    counter_with_data_feature: cross apb_address,apb_data,apb_transfer{
      //bins write_CDR_data           = binsof(apb_address.CDR_addr) && binsof(apb_transfer.apb_write) && binsof(apb_data.data_value);
      ignore_bins write_data    = !binsof(apb_address.CDR_addr) || !binsof(apb_transfer.apb_write) || !binsof(apb_data.data_value);
    }
  endgroup

  function new(mailbox #(packet) m2s_mb);
    this.m2s_mb = m2s_mb;
    APB_GROUP = new();
  endfunction

  task run();

    while(1) begin
      m2s_mb.get(pkt);
      APB_GROUP.sample();
      $display("%0t: [scoreboard] Get packet from monitor: %s: addr = %b, data = %h",
                                                          $time,pkt.transfer.name(),pkt.addr,pkt.data);
    end
  endtask

endclass

class stimulus;
  mailbox #(packet) s2d_mb;
  packet pkt_q[$];

  function new(mailbox #(packet) s2d_mb);
    this.s2d_mb = s2d_mb;
  endfunction

  function void create_pkt(bit up_down=1'b1,bit enable=1'b1);
    packet pkt = new();
    pkt.up_down = up_down;
    pkt.enable  = enable;
    pkt_q.push_back(pkt);
  endfunction

  task run();
    packet pkt;
    while(1) begin
      wait(pkt_q.size >0);
      pkt = pkt_q.pop_front();
      s2d_mb.put(pkt);
      $display("%0t: [stimulus] Sent packet to driver",$time);
    end
  endtask

endclass

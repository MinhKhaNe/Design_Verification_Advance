class stimulus;
  mailbox #(packet) s2d_mb;
  packet pkt_q[$];

  function new(mailbox #(packet) s2d_mb);
    this.s2d_mb = s2d_mb;
  endfunction

  function void create_pkt(packet pkt);
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

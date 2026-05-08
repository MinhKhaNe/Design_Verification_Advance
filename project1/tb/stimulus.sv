class stimulus;

  mailbox #(packet) s2d_mb;
  packet pkt_q[$];              //Create queue to store packets
  int num;                      //Number of loop

  function new(mailbox #(packet) s2d_mb);
    this.s2d_mb = s2d_mb;
  endfunction

  task send_pkt(packet pkt);
    pkt_q.push_back(pkt);       //Receive packet and send to Driver
  endtask

  task run();
    packet pkt;
    while(1) begin
      wait(pkt_q.size > 0);
      pkt = pkt_q.pop_front();  
      s2d_mb.put(pkt);          //Put packet to mailbox
      $display("[Stimulus] Packet is sent to Driver");
    end
  endtask

endclass

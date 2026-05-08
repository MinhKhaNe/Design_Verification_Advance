module testbench;
  reg[2:0]  pid;
  reg       valid;
  wire[7:0] data;

  encoder u_dut(.*);

  // TODO User code

  int done = 0;
  import data_type_pkg::*;

  mailbox #(packet_st) exp_mb = new(); 
  mailbox #(packet_st) act_mb = new();

  bit [2:0] rand_val [] = '{3'd1,3'd3,3'd4,3'd5};

  initial begin
    
    fork
	stimulus();
	monitor();
	compare();
    join

    #1000ns;
    $display("End of simulation");
    $finish;
  end

  task stimulus();
	packet_st pkg;
	bit [2:0] data_in;
	bit [7:0] data_out;
	repeat (5) begin
		data_in = rand_val[$urandom_range(0,3)];
		pid	= data_in;
		$display("===== Drive Pid = %d =====",pid);
		//valid   = 1'b1;
		#10;
		case(data_in) 
			3'd4:	data_out = 8'h15;
			3'd1:	data_out = 8'h1;
			3'd3: 	data_out = 8'h34;
			3'd5:	data_out = 8'hfc;
		endcase
		$display("===== Convert data from Pid =====");
		valid = 1'b1;
		#10;
		pkg.pid = data_in;
		pkg.data = data_out;
		#1;
		exp_mb.put(pkg);
		valid	= 1'b0;
		done = done + 1;
		#50;
	end
  endtask

  task monitor();
	packet_st pkg_2;
	forever begin
		wait(valid);
		#1;
		pkg_2.pid = pid;
		pkg_2.data = data;
		#10;
		act_mb.put(pkg_2);
		#10;
		$display("===== Sent data to actual box =====");
		if (done == 5) break;
	end
  endtask

  task compare();
	packet_st exp_pkg, act_pkg;
	forever  begin
		exp_mb.get(exp_pkg);
		#10;
		$display("===== Get expected package =====");
		act_mb.get(act_pkg); 
		#10;
		$display("===== Get actual package =====");
		if(exp_pkg.data == act_pkg.data) begin
			$display("===== Data encode matching %h =====\n",exp_pkg.data);
		end
		else begin
			$display("===== Data mismatch !!! Expected data is %h, Actual data is %h =====",exp_pkg.data,act_pkg.data);
		end
		if(done == 5) break;
	end
  endtask
endmodule

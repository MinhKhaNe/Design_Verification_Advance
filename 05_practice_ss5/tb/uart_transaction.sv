class uart_transaction;
  typedef enum {ODD,EVEN} parity_enum;
  rand bit [7:0] data;
  rand bit parity;
  rand int stop_bit;

  rand parity_enum parity_mode;
  rand int baud_rate;

  function new();
  endfunction

  // TODO user code - write constraint

//  constraint stop_bit_constraint{
//   if(baud_rate == 9600 || baud_rate ==14400) {
//    stop_bit == 1;
 //  }
//   else {
//    stop_bit == 2;
//   }
//  };

//  constraint parity_constraint {
//   if(parity_mode == ODD){
//    parity == ^data;
 //  }
//   else {
//    parity == ~(^data);
//   }
//  }

  constraint stop_bit_constraint {
   baud_rate == 9600 || baud_rate == 14400 -> stop_bit == 1;
   baud_rate == 19200 || baud_rate == 115200 -> stop_bit == 2;
  }

  constraint parity_constraint {
   parity_mode == ODD -> parity == ^data;
   parity_mode == EVEN -> parity == ~(^data);
  }


  function void display();
    $display("[uart_transaction] UART Frame: Data = 8'b%b, Parity = %0b, Stop bit = %0d stop bit with baud rate = %0d and parity_mode = %s",data,parity,stop_bit,baud_rate,parity_mode.name());
  endfunction

endclass



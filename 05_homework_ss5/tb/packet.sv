class packet;
  typedef enum {STANDARD, FAST, FAST_PLUS} i2c_mode_enum;

  rand bit[6:0]  slave_addr;
  rand bit[7:0]  data_in;
  rand bit[15:0] scl_low_time;
  rand bit[15:0] scl_high_time;
  rand bit[15:0] sda_hold_time;
  rand i2c_mode_enum i2c_mode;

  function new();
  endfunction

  constraint scl_lt_rand {
    i2c_mode == STANDARD  -> scl_low_time >= 4700;
    i2c_mode == FAST      -> scl_low_time >= 1300;
    i2c_mode == FAST_PLUS -> scl_low_time >= 500;
  };

  constraint scl_ht_rand {
    i2c_mode == STANDARD  -> scl_high_time >= 4000;
    i2c_mode == FAST      -> scl_high_time >= 600;
    i2c_mode == FAST_PLUS -> scl_high_time >= 260;
  };

  constraint scl_limit {
    i2c_mode == STANDARD  -> (scl_high_time + scl_low_time) <= 10000;
    i2c_mode == FAST      -> (scl_high_time + scl_low_time) <= 2500;
    i2c_mode == FAST_PLUS -> (scl_high_time + scl_low_time) <= 1000;
  };

  constraint sda_ht_rand {
    i2c_mode == STANDARD  -> sda_hold_time >= 300;
    i2c_mode == FAST      -> sda_hold_time >= 300;
    i2c_mode == FAST_PLUS -> sda_hold_time >= 300;
  };

  constraint sda_ht_limit {
    i2c_mode == STANDARD  -> sda_hold_time <= scl_low_time - 250;   //Hold = SCL_Low - SetUp
    i2c_mode == FAST      -> sda_hold_time <= scl_low_time - 100;
    i2c_mode == FAST_PLUS -> sda_hold_time <= scl_low_time - 50;
  }

endclass



class ahb_base_test extends uvm_test;
  `uvm_component_utils(ahb_base_test)

  ahb_environment ahb_env;
  virtual ahb_if  ahb_vif;

  function new(string name="ahb_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ahb_if)::get(this, "", "ahb_vif", ahb_vif)) begin
      `uvm_fatal("ahb_base_test",$sformatf("FAILED to get ahb_if from uvm_config_db"))
    end
    
    ahb_env = ahb_environment::type_id::create("ahb_env",this);

    uvm_config_db#(virtual ahb_if)::set(this, "ahb_env", "ahb_vif", ahb_vif);
   
  endfunction: build_phase
  
  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("start_of_simulation_phase","Entered...",UVM_HIGH)
    uvm_top.print_topology();
    `uvm_info("start_of_simulation_phase","Exiting...",UVM_HIGH)
  endfunction


endclass


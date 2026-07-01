`include "uvm_macros.svh"
 import uvm_pkg::*;
  
typedef enum bit [2:0] {wrrdfixed = 0, wrrdincr = 1, wrrdwrap = 2, wrrderrfix = 3,  rstdut = 4 } oper_mode;


//============================  
//======= SEQUENCE-1 (RST) ===
//============================ 
class rst_dut extends uvm_sequence#(transaction);
  `uvm_object_utils(rst_dut)
  
  transaction tr;
 
  function new(string name = "rst_dut");
    super.new(name);
  endfunction
   
  virtual task body();
    repeat(5)
      begin
        tr = transaction::type_id::create("tr");
         $display("------------------------------");
        `uvm_info("SEQ", "Sending RST Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
        tr.op  = rstdut;
        finish_item(tr);
      end
  endtask
   
endclass
 
//======================================
//=== SEQUENCE-2 (FIXED BURST) =========
//====================================== 
class valid_wrrd_fixed extends uvm_sequence#(transaction);
  `uvm_object_utils(valid_wrrd_fixed)
  
  transaction tr;
 
  function new(string name = "valid_wrrd_fixed");
    super.new(name);
  endfunction
   
  virtual task body();
 
        tr = transaction::type_id::create("tr");
        $display("------------------------------");
        `uvm_info("SEQ", "Sending Fixed mode Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrdfixed;
          tr.awlen   = 7;
          tr.awburst = 0;
          tr.awsize  = 2;
       
        finish_item(tr);
  endtask
   
endclass
//=========================================
//==== SEQUENCE-3 (INCR BURST) ============
//========================================= 
class valid_wrrd_incr extends uvm_sequence#(transaction);
  `uvm_object_utils(valid_wrrd_incr)
  
  transaction tr;
 
  function new(string name = "valid_wrrd_incr");
    super.new(name);
  endfunction
   
  virtual task body();
        tr = transaction::type_id::create("tr");
        $display("------------------------------");
        `uvm_info("SEQ", "Sending INCR mode Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrdincr;
          tr.awlen   = 7;
          tr.awburst = 1;
          tr.awsize  = 2;
          
        finish_item(tr);
  endtask
   
endclass
//=============================== 
//=== SEQUENCE-4 (WRAP BURST) ===
//===============================
class valid_wrrd_wrap extends uvm_sequence#(transaction);
  `uvm_object_utils(valid_wrrd_wrap)
  
  transaction tr;
 
  function new(string name = "valid_wrrd_wrap");
    super.new(name);
  endfunction
   
  virtual task body();
        tr = transaction::type_id::create("tr");
         $display("------------------------------");
        `uvm_info("SEQ", "Sending WRAP mode Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrdwrap;
          tr.awlen   = 7;
          tr.awburst = 2;
          tr.awsize  = 2;
          
        finish_item(tr);
  endtask
  
endclass
//================================== 
//=== SEQUENCE-5 (ERROR) ===========
//==================================
 
class err_wrrd_fix extends uvm_sequence#(transaction);
  `uvm_object_utils(err_wrrd_fix)
  
  transaction tr;
 
  function new(string name = "err_wrrd_fix");
    super.new(name);
  endfunction
   
  virtual task body();
        tr = transaction::type_id::create("tr");
        $display("------------------------------");
        `uvm_info("SEQ", "Sending Error Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrderrfix;
          tr.awlen   = 7;
          tr.awburst = 0;
          tr.awsize  = 2;   
        finish_item(tr);
  endtask
   
endclass


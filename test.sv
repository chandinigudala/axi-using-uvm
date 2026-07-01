`include "uvm_macros.svh"
 import uvm_pkg::*;
  
typedef enum bit [2:0] {wrrdfixed = 0, wrrdincr = 1, wrrdwrap = 2, wrrderrfix = 3,  rstdut = 4 } oper_mode;




//==========================
//===== TEST ==============
//==========================
class test extends uvm_test;
`uvm_component_utils(test)
 
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction
  
env e;

valid_wrrd_fixed vwrrdfx;
valid_wrrd_incr  vwrrdincr;
valid_wrrd_wrap  vwrrdwrap;
err_wrrd_fix     errwrrdfix;
rst_dut rdut; 
  
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
   e = env::type_id::create("env",this);
  vwrrdfx = valid_wrrd_fixed::type_id::create("vwrrdfx");
  vwrrdincr = valid_wrrd_incr::type_id::create("vwrrdincr");
  vwrrdwrap = valid_wrrd_wrap::type_id::create("vwrrdwrap");
  errwrrdfix = err_wrrd_fix::type_id::create("errwrrdfix");
  rdut = rst_dut::type_id::create("rdut");
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);

rdut.start(e.a.seqr);       //testcase-1 (reset)
#50;

//vwrrdfx.start(e.a.seqr);    //testcase-2 (fixed)
//#50;

//vwrrdincr.start(e.a.seqr);  //testcase-3 (incr)
//#50;

vwrrdwrap.start(e.a.seqr);  //testcase-4 (wrap) 
#50;

//errwrrdfix.start(e.a.seqr); //testcase-5 (error) 
//#50;
 
phase.drop_objection(this);
endtask
endclass
 


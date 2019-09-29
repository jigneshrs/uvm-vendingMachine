//
// A simple driver for the vending machine
//
`timescale 1us/1ns

//`include "vend.sv"

`include "vend_intf.svh"



module top();

import uvm_pkg::*;

`include "uvm_pkg.sv";
`include "uvm_macros.svh";
`include "vm_pkg.sv";

reg clk,rst;
vend_intf vendx(clk,rst);

initial begin
    clk=0;
    rst=0;
    #5;
    repeat(50000000) begin
        #2 clk=1;
        #2 clk=0;
    end
    $display("\n\n\nRan out of clocks\n\n\n");
    $finish;
end

initial begin
	$display("-------------------- Before run test ---------------------");
    uvm_config_db #(virtual vend_intf)::set(null, "*", "vend_intf" , vendx);
    run_test("vm_test");
	$display("---------------- After run test ------------------- ");
end

vend v(vendx.clk,vendx.reset,vendx.detect_5 
    ,vendx.detect_10 ,vendx.detect_25 ,vendx.amount 
    ,vendx.buy ,vendx.return_coins 
    ,vendx.empty_5 ,vendx.empty_10 ,vendx.empty_25 
    ,vendx.ok ,vendx.return_5 
    ,vendx.return_10 ,vendx.return_25);

endmodule : top


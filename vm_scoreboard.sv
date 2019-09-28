// Class for vm scoreboard

class vm_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(vm_scoreboard)

uvm_tlm_analysis_fifo #(vm_seq_item) sb_port;
uvm_tlm_analysis_fifo #(vm_seq_item) sb_resPort;

vm_seq_item req1,req2;

function new (string name = "vm_scoreboard", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void build_phase (uvm_phase phase);
begin
	sb_port = new("sb_port",this);
	sb_resPort = new("sb_resPort",this);
end
endfunction : build_phase

task run_phase (uvm_phase phase);

fork
	forever begin
	sb_port.get(req1);
	sb_resPort.get(req2);
	// write logic for vm on scoreboard side for comparision

	if(req1.ok !== req2.ok) begin
		`uvm_error("Ohhh boy", $sformatf("Expected ok : %b, Actual ok : %b", req1.ok, req2.ok))
	end
	end
join_none

endtask : run_phase 
/*
function void report_phase(uvm_phase phase);

if(sb_port.used() > 0) begin
	`uvm_error("Ohhh shame", "not all data pushed out")
end

endfunction : report_phase
*/
endclass : vm_scoreboard

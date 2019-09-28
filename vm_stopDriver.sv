// Class for stop driver

class vm_stopDriver extends uvm_driver #(vm_seq_item);
	`uvm_component_utils(vm_stopDriver)

vm_seq_item req;

virtual vm_if vmif;

function new (string name = "vm_stopDriver", uvm_componenet parent = null);
	super.new(name,parent);
endfunction

function void connect_phase(uvm_phase phase);
	if(!uvm_config_db #(virtual vm_if)::get(null, "uvm__test_top", "vm_if", this.vmif)) begin
		`uvm_error("connect", "virtual interface not found")
	end
endfunction : connect_phase

task run_phase(uvm_phase phase);

fork
	forever begin
	seq_item_port.get_next_item(req); // This will get vm seq item
	#1;
	seq_item_port.item_done();
	end
join_none
	
endtask : run_phase

endclass : vm_stopDriver

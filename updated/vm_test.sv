// Class for vm test

class vm_test extends uvm_test;


vm_env env;
vm_sequence req;

`uvm_component_utils_begin(vm_test)
	`uvm_field_object(env, UVM_ALL_ON);
`uvm_component_utils_end

function new (string name = "vm_test", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void build_phase (uvm_phase phase);
	env = vm_env::type_id::create("env",this);
endfunction : build_phase

task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	req = vm_sequence::type_id::create("req",this);
	req.start(env.agent.seqr);
	#100;
	phase.drop_objection(this);
endtask

endclass : vm_test

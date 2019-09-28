// Class for vm test

class vm_test extends uvm_test;


vm_env env;

`uvm_component_utils_begin(vm_test)
	`uvm_field_object(env, UVM_ALL_ON);
`uvm_component_utils_end

function new (string name = "vm_test", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void build_phase (uvm_phase phase);
	env = vm_env::type_id::create("env",this);
endfunction : build_phase

endclass : vm_test

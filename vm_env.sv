// Class for vm env.

class vm_env extends uvm_env;


vm_agent agent;

`uvm_component_utils_begin(vm_env)
	`uvm_field_object(agent, UVM_ALL_ON)
`uvm_component_utils_end

function new (string name = "vm_env", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	agent = vm_agent::type_id::create("agent",this);
endfunction : build_phase

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
endfunction : connect_phase

endclass : vm_env

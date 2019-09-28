// Class for result monitor

class vm_resultMonitor extends uvm_monitor;
	`uvm_component_utils(vm_resultMonitor)

uvm_analysis_port #(vm_seq_item) mon_port;
vm_seq_item req;

virtual vend_intf vmif_mon;

function new (string name = "vm_resultMonitor", uvm_component parent = null);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
begin
	mon_port = new("mon_port",this);
end
endfunction : build_phase

function void connect_phase (uvm_phase phase);
	if(!uvm_config_db #(virtual vend_intf)::get(null, "uvm_test_top", "vend_intf", this.vmif_mon)) begin
		`uvm_error("connect", "virtual interface in monitor not found")
	end
endfunction : connect_phase

task run_phase(uvm_phase phase);
begin
	fork
		forever begin
		@(posedge (vmif_mon.clk));
		req = new();
		req.return_5 = vmif_mon.return_5;
		req.return_10 = vmif_mon.return_10;
		req.return_25 = vmif_mon.return_25;
		req.ok = vmif_mon.ok;
		mon_port.write(req);
	end
	join_none
end
endtask : run_phase

endclass : vm_resultMonitor

// This is class for main monitor
class vm_monitor extends uvm_monitor;
	`uvm_component_utils(vm_monitor)

uvm_analysis_port #(vm_seq_item) mon_port;
vm_seq_item req;

virtual vend_intf vmif_mon;

function new (string name = "vm_monitor", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void build_phase(uvm_phase phase);
	begin
	mon_port = new("mon_port",this);
	end
endfunction : build_phase

function void connect_phase(uvm_phase phase);
	if(!uvm_config_db #(virtual vend_intf)::get(null, "uvm_test_top","vend_intf", this.vmif_mon)) begin
		`uvm_error("connect", "virtual interface not found")
	end
endfunction : connect_phase

task run_phase(uvm_phase phase);
begin
	fork
		forever begin
		@(posedge vmif_mon.clk)
		req = new();
		req.detect_5 = vmif_mon.detect_5;
		req.detect_10 = vmif_mon.detect_10;
		req.detect_25 = vmif_mon.detect_25;
		req.buy = vmif_mon.buy;
		mon_port.write(req);
		end
	join_none
end
endtask : run_phase

endclass : vm_monitor


// Class for main driver
//

class vm_driver extends uvm_driver #(vm_seq_item);
	`uvm_component_utils(vm_driver)

vm_seq_item req;

virtual vend_intf vmdriver;

function new(string name = "vm_driver", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void connect_phase(uvm_phase phase);
	if(!uvm_config_db #(virtual vend_intf)::get(null, "uvm_test_top", "vend_intf", this.vmdriver)) begin
	`uvm_error("connect", "virtul interface not found in driver")
	end
endfunction : connect_phase

task run_phase(uvm_phase phase);
fork
forever begin
	seq_item_port.get_next_item(req);
	#5;
	if(req.reset) begin
		vmdriver.reset = 1;
		#2;
		vmdriver.reset = 0;
	end
	else begin
		vmdriver.reset = req.reset;
	end

	if(!reset) begin
		vmdriver.detect_5 = req.detect_5;
		vmdriver.detect_10 = req.detect_10;
		vmdriver.detect_25 = req.detect_25;
	end
	
	//vmdriver.detect_5 = req.detect_5;
	//vmdriver.detect_10 = req.detect_10;
	//vmdriver.detect_25 = req.detect_25;
	//vmdriver.buy = req.buy;
	$display("------------  Driver to interface All values -------------");
	$display("Sequence >> 5C : %b, 10C : %b, 25C : %b, buy : %b",req.detect_5, req.detect_10, req.detect_25, req.buy);
	$display("Interface >>> 5C : %b, 10C : %b, 25C : %b, buy : %b",vmdriver.detect_5,vmdriver.detect_10,vmdriver.detect_25,vmdriver.buy);
	
	#3;
	seq_item_port.item_done();
end
join_none
endtask : run_phase


endclass : vm_driver


// Class for stop driver

class vm_stopDriver extends uvm_driver #(vm_seq_item);
	`uvm_component_utils(vm_stopDriver)

vm_seq_item req;

virtual vend_intf vmif;

function new (string name = "vm_stopDriver", uvm_component parent = null);
	super.new(name,parent);
endfunction

function void connect_phase(uvm_phase phase);
	if(!uvm_config_db #(virtual vend_intf)::get(null, "uvm__test_top", "vend_intf", this.vmif)) begin
		`uvm_error("connect", "virtual interface not found in result driver")
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

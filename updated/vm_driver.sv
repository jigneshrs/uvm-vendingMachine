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

in_coin coins;

forever begin
		
	@(posedge vmdriver.clk);
	
	if(vmdriver.reset) begin
		vm_reset(vmdriver);
	end
	else begin
		seq_item_port.get_next_item(req);
	        vmdriver.empty_5 = req.empty_5;
	        vmdriver.empty_10 = req.empty_10;
	        vmdriver.empty_25 = req.empty_25;
		vmdriver.amount = req.amount;

	//	req.do_print("Driver",1);
		
		while(req.coin_insert.size())begin
			coins = req.coin_insert.pop_front();
			case(coins)
			c5 : begin
			vmdriver.detect_5 = 1;
			vmdriver.detect_10 = 0;
			vmdriver.detect_25 = 0;
			end
			c10 : begin
			vmdriver.detect_5 = 0;
			vmdriver.detect_10 = 1;
			vmdriver.detect_25 = 0;
			end
			c25 : begin
			vmdriver.detect_5 = 0;
			vmdriver.detect_10 = 0;
			vmdriver.detect_25 = 1;
			end
			endcase
		repeat(3)@(posedge vmdriver.clk);
		vmdriver.detect_5 = 0;
		vmdriver.detect_10 = 0;
		vmdriver.detect_25 = 0;
		repeat(100)@(posedge vmdriver.clk);	
		vmdriver.detect_5 = 0;
		vmdriver.detect_10 = 0;
		vmdriver.detect_25 = 0;
		end

		vmdriver.detect_5 = 0;
		vmdriver.detect_10 = 0;
		vmdriver.detect_25 = 0;
	
		vmdriver.buy = req.buy;
		vmdriver.return_coins = req.return_coins;

		repeat(2)@(posedge vmdriver.clk);
		vmdriver.buy = 0;
		vmdriver.return_coins = 0;

		repeat(200)@(posedge vmdriver.clk);
		vmdriver.amount = 0;

		repeat(30000)@(posedge vmdriver.clk);
		vmdriver.detect_5 = 0;
		vmdriver.detect_10 = 0;
		vmdriver.detect_25 = 0;

	$display("------------  Driver to interface All values -------------");	
	seq_item_port.item_done();
	end
end
endtask : run_phase

function vm_reset(virtual vend_intf vmdriver);
    vmdriver.detect_5 = 0;
    vmdriver.detect_10 = 0;
    vmdriver.detect_25 = 0;
    vmdriver.empty_5 = 0;
    vmdriver.empty_10 = 0;
    vmdriver.empty_25 = 0;
    vmdriver.amount = 0;
    vmdriver.return_coins = 0;
    vmdriver.buy = 0;
endfunction


endclass : vm_driver

/*
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
*/

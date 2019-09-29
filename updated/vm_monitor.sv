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

int count = 0;
req = new();
req.reset();
forever begin
	
	if( req.buy || req. return_coins ) begin
	count++;
		if( count == 30000 || vmif_mon.detect_5 || vmif_mon.detect_10 || vmif_mon.detect_25) begin
			mon_port.write(req);
			count = 0;
			req.reset();
		end
	end

	if(vmif_mon.buy) begin
	req.amount = vmif_mon.buy;
		while(vmif_mon.buy) begin
			@(posedge vmif_mon.clk);
		end
		req.buy = 1;
	end	

	if(vmif_mon.ok) begin
		while(vmif_mon.ok) begin
			@(posedge vmif_mon.clk);
		end
		req.ok = 1;
	end	
	
	if(vmif_mon.return_coins) begin
		while(vmif_mon.return_coins) begin
			@(posedge vmif_mon.clk);
		end
		req.return_coins = 1;
	end	

	if(vmif_mon.return_5) begin
		while(vmif_mon.return_5) begin
			@(posedge vmif_mon.clk);
		end
		req.coin_insert.push_back(c5);
		req.amount_returned = req.amount_returned + 5;
	end	

	if(vmif_mon.return_10) begin
		while(vmif_mon.return_10) begin
			@(posedge vmif_mon.clk);
		end
		req.coin_insert.push_back(c10);
		req.amount_returned = req.amount_returned + 10;
	end
	
	if(vmif_mon.return_25) begin
		while(vmif_mon.return_25) begin
			@(posedge vmif_mon.clk);
		end
		req.coin_insert.push_back(c25);
		req.amount_returned = req.amount_returned + 25;
	end

	@(posedge vmif_mon.clk);	
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
req = new();
req.reset();
forever begin

	if(vmif_mon.detect_5) begin
		while(vmif_mon.detect_5) begin
			@(posedge vmif_mon.clk);
		end
		req.coin_insert.push_back(c5);
		req.amount_pushed = req.amount_pushed + 5;
	end

	if(vmif_mon.detect_10) begin
		while(vmif_mon.detect_10) begin
			@(posedge vmif_mon.clk);
		end
		req.coin_insert.push_back(c10);
		req.amount_pushed = req.amount_pushed + 10;
	end

	if(vmif_mon.detect_25) begin
		while(vmif_mon.detect_25) begin
			@(posedge vmif_mon.clk);
		end
		req.coin_insert.push_back(c25);
		req.amount_pushed = req.amount_pushed + 25;
	end

	if(vmif_mon.empty_5) begin
		req.empty_5 = 1;
	end

	if(vmif_mon.empty_10) begin
		req.empty_10 = 1;
	end

	if(vmif_mon.empty_25) begin
		req.empty_25 = 1;
	end

	if(vmif_mon.buy) begin
	req.amount = vmif_mon.buy;
		while(vmif_mon.buy) begin
			@(posedge vmif_mon.clk);
		end
		req.buy = 1;
		req.returnAmount_expected = req.amount - req.amount_pushed;
		if(req.amount_pushed >= req.amount)
			req.ok_expected = 1;
		else
			req.ok_expected = 0;
		mon_port.write(req);
		req.reset();
	end		
	
	if(vmif_mon.return_coins) begin
		while(vmif_mon.return_coins) begin
			@(posedge vmif_mon.clk);
		end
		req.return_coins = 1;
		req.returnAmount_expected = req.amount;
		req.ok_expected = 0;
		mon_port.write(req);
		req.reset();
	end	


	@(posedge vmif_mon.clk);	

end
endtask : run_phase

endclass : vm_monitor


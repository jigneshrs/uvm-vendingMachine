// Class for vm scoreboard
`uvm_analysis_imp_decl(_in)
`uvm_analysis_imp_decl(_out)

class vm_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(vm_scoreboard)

//uvm_tlm_analysis_fifo #(vm_seq_item) sb_port;
//uvm_tlm_analysis_fifo #(vm_seq_item) sb_resPort;

uvm_analysis_imp_in #(vm_seq_item, vm_scoreboard) sb_port;
uvm_analysis_imp_out #(vm_seq_item, vm_scoreboard) sb_resPort;

vm_seq_item inSeq[$], outSeq[$];

vm_seq_item req1,req2;
vm_seq_item out_req1, out_req2;

logic [8:0] result;

function new (string name = "vm_scoreboard", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void build_phase (uvm_phase phase);
begin
	super.build_phase(phase);
	sb_port = new("sb_port",this);
	sb_resPort = new("sb_resPort",this);
end
endfunction : build_phase

function void write_in(vm_seq_item _inSeq);
	req1 = new _inSeq;
	inSeq.push_back(req1);
endfunction

function void write_out(vm_seq_item _outSeq);
	req2 = _outSeq;
	outSeq.push_back(req2);
endfunction

task run_phase (uvm_phase phase);

forever begin
	if(inSeq.size() && outSeq.size() ) begin
	
	out_req1 = inSeq.pop_front();
	out_req2 = outSeq.pop_front();

//	out_req1.do_print("Scoreboard(Tx)",1);
//	out_req2.do_print("Scoreboard(Rx)",0);
	
	if(out_req1.ok_expected != out_req2.ok) begin
		if(out_req1.ok_expected)
			`uvm_error(get_name, $sformatf(" Prouduct shouled be dispensed, as OK is 1"))
		else
			`uvm_error(get_name, $sformatf(" Prouduct shouled not be dispensed, as OK is 0"))
	end

	if(out_req1.returnAmount_expected != out_req2.amount_returned) begin
		`uvm_error(get_name, $sformatf("Return amount : %0d , Expected return amount : %0d ",out_req2.amount_returned, out_req1.returnAmount_expected))
	end

	if(out_req1.empty_5) begin
		for(int i = 0; i < out_req2.coin_return.size; i++) begin
			if(out_req2.coin_return[i] == c5) begin
				`uvm_error(get_name(),$sformatf(" Empty coin 5, it should not return c5"))
			end
		end
	end
	
	if(out_req1.empty_10)begin
		for(int i = 0; i < out_req2.coin_return.size; i++) begin
			if(out_req2.coin_return[i] == c10) begin
				`uvm_error(get_name(),$sformatf(" Empty coin 10, it should not return c10"))
			end
		end
	end	

	if(out_req1.empty_25) begin
		for(int i = 0; i < out_req2.coin_return.size; i++) begin
			if(out_req2.coin_return[i] == c25) begin
				`uvm_error(get_name(),$sformatf(" Empty coin 25, it should not return c25"))
			end
		end
	end	

	end
	#10;
end

endtask : run_phase 
/*
function void report_phase(uvm_phase phase);

if(sb_port.used() > 0) begin
	`uvm_error("Ohhh shame", "not all data pushed out")
end

endfunction : report_phase
*/
endclass : vm_scoreboard

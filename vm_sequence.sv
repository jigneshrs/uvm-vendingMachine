// Class for VM sequence

class vm_sequence extends uvm_sequence #(vm_seq_item);
	`uvm_object_utils(vm_sequence)

// vm sequence item
vm_seq_item req1;

// controls no. of request sequence items sent
rand int no_reqs = 1;

function new (string name = "vm_sequence");
	super.new(name);
endfunction : new

constraint vm_amount { req1.amount <= 50; }

task body;
begin
	req1 = vm_seq_item::type_id::create("req1");
	//req2 = vm_seq_item::type_id::create("req2");
	repeat(no_reqs) begin
		start_item(req1);
		req1.randomize();	
		finish_item(req1);
	end
end
endtask : body

endclass : vm_sequence


// Class for stop sequence

class vm_stopSeq extends uvm_sequence #(vm_seq_item);
	`uvm_object_utils(vm_stopSeq)

vm_seq_item req1;

rand int no_reqs = 1;

function new (string name = "vm_stopSeq");
	super.new(name);
endfunction : new

task body;
begin
	req1 = vm_seq_item::type_id::create("request1");
	repeat(no_reqs) begin
	start_item(req1);
	finish_item(req1);
	end
end
endtask : body


endclass : vm_stopSeq

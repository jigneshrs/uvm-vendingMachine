// Class for sequencer
//

class vm_sequencer extends uvm_sequencer #(vm_seq_item);
	`uvm_object_utils(vm_sequencer)

function new(string name="vm_sequencer");
	super.new(name);
endfunction : new

endclass : vm_sequencer


// Class for stop sequencer
//
class vm_stopSequencer extends uvm_sequencer #(vm_seq_item);
	`uvm_object_utils(vm_stopSequencer)

function new (string name = "vm_stopSequencer");
	super.new(name);
endfunction : new

endclass : vm_stopSequencer

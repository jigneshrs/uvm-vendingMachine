// Class for agent
//
class vm_agent extends uvm_agent;
//`uvm_component_utils(vm_agent)


vm_driver driver;
//vm_stopDriver stopDriver;
vm_sequence seq;
vm_sequencer seqr;
//vm_stopSequencer stopSeqr;
vm_monitor monitor;
vm_resultMonitor resultMonitor;
vm_scoreboard scoreboard1;
//vm_stopSeq stopSeq;

`uvm_component_utils_begin(vm_agent)
	`uvm_field_object(driver, UVM_ALL_ON)
//	`uvm_field_object(stopDriver, UVM_ALL_ON)
	`uvm_field_object(seq, UVM_ALL_ON)
	`uvm_field_object(seqr, UVM_ALL_ON)
//	`uvm_field_object(stopSeqr, UVM_ALL_ON)
	`uvm_field_object(monitor, UVM_ALL_ON)
	`uvm_field_object(resultMonitor, UVM_ALL_ON)
`uvm_component_utils_end

function new (string name = "vm_agent", uvm_component parent = null);
	super.new(name,parent);
endfunction : new

function void build_phase (uvm_phase phase);
begin
	super.build_phase(phase);
	seq = vm_sequence::type_id::create("seq",this);
	seqr = vm_sequencer::type_id::create("seqr",this);
	driver = vm_driver::type_id::create("driver",this);
	//stopDriver = vm_stopDriver::type_id::create("stopDriver",this);
	//stopSeqr = vm_stopSequencer::type_id::create("stopSeqr",this);
	monitor = vm_monitor::type_id::create("monitor",this);
	resultMonitor = vm_resultMonitor::type_id::create("resultMonitor",this);
	scoreboard1 = vm_scoreboard::type_id::create("scoreboard1",this);
	//stopSeq = vm_stopSeq::type_id::create("stopSeq",this);
end
endfunction

function void connect_phase(uvm_phase phase);
	driver.seq_item_port.connect(seqr.seq_item_export);
	//stopDriver.seq_item_port.connect(stopSeqr.seq_item_export);
	//monitor.mon_port.connect(scoreboard1.sb_port.analysis_export);
	//resultMonitor.mon_port.connect(scoreboard1.sb_resPort.analysis_export);
endfunction : connect_phase

/*
task run_phase(uvm_phase phase);

phase.raise_objection(this, "start of test");
seq.start(seqr);
	fork
	seq.start(seqr);
	stopSeq.start(stopSeqr);
	join
	phase.drop_objection(this, "end of test");

endtask : run_phase
*/
endclass : vm_agent

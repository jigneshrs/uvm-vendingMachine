class vm_seq_item extends uvm_sequence_item;

rand bit detect_5, detect_10, detect_25;
bit buy, return_coins, reset;
rand bit [9] amount;
bit empty_5, empty_10, empty_25;
bit ok, return_5, return_10, return_25;
rand int cn5, cn10, cn25;

`uvm_object_utils_begin(vm_seq_item)
	`uvm_field_int(detect_5, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(detect_10, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(detect_25, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_filed_int(amount, UVM_ALL_ON)
	`uvm_field_int(return_coins, UVM_ALL_ON)	
	`uvm_field_int(empty_5, UVM_ALL_ON)
	`uvm_field_int(empty_10, UVM_ALL_ON)
	`uvm_field_int(empty_25, UVM_ALL_ON)
	`uvm_field_int(ok, UVM_ALL_ON)
	`uvm_field_int(buy, UVM_ALL_ON | UVM_NOCOMPARE)
`uvm_object_utils_end

function new (string name = "vm_seq_item");
	super.new(name);
endfunction : new

function void do_copy(uvm_object rhs);
	vm_seq_item rhs_;
	
	if(!$cast(rhs_, rhs)) begin
		uvm_report_error("d_copy", "cast failed, check types");
	end

	detect_5 = rhs_.detect_5;
	detect_10 = rhs_.detect_10;
	detect_25 = rhs_.detect_25;
	buy = rhs_.buy;
	return_5 = rhs_.return_5;
	return_10 = rhs_.return_10;
	return_25 = rhs_.return_25;
	ok = rhs_.ok;
endfunction : do_copy

function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	vm_seq_item rhs_;
	
	do_compare = $cast(rhs_, rhs) &&
		super.do_compare(rhs, comparer) &&
	detect_5 == rhs_.detect_5 &&
	detect_10 == rhs_.detect_10 &&
	detect_25 == rhs_.detect_25 &&
	buy == rhs_.buy &&
	return_5 == rhs_.return_5 &&
	return_10 == rhs_.return_10 &&
	return_25 == rhs_.return_25 &&
	ok == rhs_.ok;
endfunction : do_compare

function string toStr();
	return $sformatf("D5 = %0d, D10 = %0d, D25 = %0d, Buy = %b, R5 = %0d, R10 = %0d, R25 = %0d, Ok = %b",detect_5,detect_10,detect_25,buy,return_5,return_10,return_25,ok);
endfunction : toStr

/*

function void do_record(uvm_recorder recorder);
	super.do_record(recorder);
	
	`uvm_record_field("detect_5",detect_5);
	`uvm_record_field("detect_10",detect_10);
	`uvm_record_field("detect_25",detect_25);
	`uvm_record_field("buy",buy);
	`uvm_record_field("return_5",return_5);
	`uvm_record_field("return_5",return_5);
	`uvm_record_field("return_25",return_25);
	`uvm_record_field("ok",ok);
endfunction : do_record
*/
endclass : vm_seq_item

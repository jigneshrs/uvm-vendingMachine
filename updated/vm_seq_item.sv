typedef enum{c5,c10,c25} in_coin;
class vm_seq_item extends uvm_sequence_item;

rand bit detect_5, detect_10, detect_25;
bit buy, return_coins, reset_vm;
bit [9] amount;
bit empty_5, empty_10, empty_25;
bit ok, return_5, return_10, return_25;


in_coin coin_insert[$];

int coin_return[$];
int amount_pushed;
int returnAmount_expected;
int amount_returned;
bit ok_expected;

`uvm_object_utils_begin(vm_seq_item)
/*	`uvm_field_int(detect_5, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(detect_10, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_field_int(detect_25, UVM_ALL_ON | UVM_NOCOMPARE)
	`uvm_filed_int(amount, UVM_ALL_ON)
	`uvm_field_int(return_coins, UVM_ALL_ON)	
	`uvm_field_int(empty_5, UVM_ALL_ON)
	`uvm_field_int(empty_10, UVM_ALL_ON)
	`uvm_field_int(empty_25, UVM_ALL_ON)
	`uvm_field_int(ok, UVM_ALL_ON)
	`uvm_field_int(buy, UVM_ALL_ON | UVM_NOCOMPARE)
*/`uvm_object_utils_end

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
/*
function void do_print(string name, bit tx);
	string s = "";
	
  s = $sformatf("%s\n ----------------------",s);
  s = $sformatf("%s\n |   PACKET IN %s",s,name);
  s = $sformatf("%s\n ----------------------",s);
  s = $sformatf("%s\n | Amount of Product %d ",s,amount);
  s = $sformatf("%s\n ----------------------",s);
  s = $sformatf("%s\n | Number of coin in insert queue %d",s,coin_insert.size());
  for(int i = 0;i<coin_insert.size();i++) begin
    s = $sformatf("%s\n | Coin at %s ",s,coin_insert[i].name());
  end
  s = $sformatf("%s\n ----------------------",s);
  s = $sformatf("%s\n | Is coin 5 empty %d",s,empty_5);
  s = $sformatf("%s\n | Is coin 10 empty %d",s,empty_10);
  s = $sformatf("%s\n | Is coin 25 empty %d",s,empty_25);
  s = $sformatf("%s\n ----------------------",s);
  s = $sformatf("%s\n | Expected Amount Received %d",s,amount_pushed);
  s = $sformatf("%s\n | Expected Return Amount %d",s,returnAmount_expected);
  s = $sformatf("%s\n | Expected OK %d",s,ok_expected);
  s = $sformatf("%s\n | Returned Amount %d",s,amount_returned);
  s = $sformatf("%s\n ----------------------",s);
 // `uvm_info(get_name(),$sformatf("%s",s),UVM_MEDIUM)
	
endfunction : do_print
*/
function void reset();

  amount = 0;
  buy = 0;
  return_coins = 0;
  ok = 0;
  empty_5 = 0;
  empty_10 = 0;
  empty_25 = 0;
  while(coin_insert.size()) begin
    coin_insert.pop_front();
  end
  while(coin_return.size()) begin
    coin_return.pop_front();
  end
  amount_pushed = 0;
  returnAmount_expected = 0;
  ok_expected = 0;
  amount_returned = 0;
endfunction

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

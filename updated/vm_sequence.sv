// Class for VM sequence

class vm_sequence extends uvm_sequence #(vm_seq_item);
	`uvm_object_utils(vm_sequence)

// vm sequence item
vm_seq_item req1;

// controls no. of request sequence items sent
int no_reqs = 1;

function new (string name = "vm_sequence");
	super.new(name);
endfunction : new

//constraint vm_amount { req1.amount <= 50; }

task body;
begin
	req1 = vm_seq_item::type_id::create("request1");
	repeat(no_reqs) begin
	start_item(req1);
        req1.amount = 115;
        req1.buy = $urandom_range(0,1);
        req1.return_coins = ~req1.buy;
        req1.coin_insert.push_back(c25);
        req1.coin_insert.push_back(c25);
        req1.coin_insert.push_back(c25);
        req1.coin_insert.push_back(c25);
        req1.coin_insert.push_back(c25);
        req1.coin_insert.push_back(c25);
	finish_item(req1);
	end

	#300000;

         repeat(no_reqs) begin 
	 start_item(req1);
         req1.amount = 120;
         req1.buy = 1; 
         req1.return_coins = ~req1.buy;
         req1.coin_insert.push_back(c5);
         req1.coin_insert.push_back(c10);
         req1.coin_insert.push_back(c25);
         req1.coin_insert.push_back(c5);
         req1.coin_insert.push_back(c25);
         req1.coin_insert.push_back(c25);
         finish_item(req1);
         end

         #300000; 
  
         repeat(no_reqs) begin 
	 start_item(req1);
         req1.amount = 35;
         req1.buy = 0; 
         req1.return_coins = ~req1.buy;
         req1.empty_25 = 0;
         req1.coin_insert.push_back(c25);
         req1.coin_insert.push_back(c25);
         finish_item(req1);
         end 
        
         #20000000; 
  
         repeat(no_reqs) begin 
	 start_item(req1);
         req1.amount = 15;
         req1.buy = 1;
         req1.return_coins = ~req1.buy;
         req1.empty_25 = 1;
         req1.coin_insert.push_back(c25);
         finish_item(req1);
         end 
        
         #300000; 
        
         repeat(no_reqs) begin 
	 start_item(req1);
         req1.amount = 40;
         req1.buy = 0;
         req1.return_coins = ~req1.buy;
         req1.empty_10 = 1;
         req1.coin_insert.push_back(c25);
         req1.coin_insert.push_back(c25);
         req1.coin_insert.push_back(c10);
         finish_item(req1);
         end

         #300000; 
        
         repeat(no_reqs) begin 
	 start_item(req1);
         req1.amount = 45;
         req1.buy = 1;
         req1.return_coins = ~req1.buy;
         req1.empty_5 = 1;
         req1.coin_insert.push_back(c25);
         req1.coin_insert.push_back(c25);
         finish_item(req1);
         end 
        
         #300000; 
        
         repeat(no_reqs) begin 
	 start_item(req1);
         req1.amount = 30;
         req1.buy = 0;
         req1.return_coins = ~req1.buy;
         req1.empty_25 = 1;
         req1.empty_10 = 1;
         req1.coin_insert.push_back(c25);
         req1.coin_insert.push_back(c25);
         finish_item(req1);
         end 
  
         #3000000;


         `uvm_info(get_name(),$sformatf("End of body of sequence"),UVM_MEDIUM)
end
endtask : body


endclass : vm_sequence

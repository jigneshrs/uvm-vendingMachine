//`include "vend.sv";
module vend_tb;

bit detect_5, detect_10, detect_25;
bit return_5, return_10, return_25;
bit buy, ok;
bit clk, reset;
bit return_coins, empty_5, empty_10, empty_25;
bit [8:0] amount;

vend dut(clk, reset, detect_5, detect_10, detect_25, amount, buy, return_coins, empty_5, empty_10, empty_25, ok, return_5, return_10, return_25);

always #0.5 clk = ~clk;

initial begin
	$dumpfile("vend.vcd");
	$dumpvars;
end

initial begin
	clk = 0;
	reset = 1;
	amount = 100;
	#1 reset = 0;
	#2 detect_5 = 1;
	#1 detect_5 = 0;
	#50 detect_10 = 1;
	#10 detect_10 = 0;
	#80 detect_10 = 1;
	#10 detect_10 = 0;
	#80 detect_25 = 1;
	#10 detect_25 = 0;
	#80 detect_25 = 1;
	#10 detect_25 = 0;
	#80 detect_25 = 1;
	#10 detect_25 = 0;
	#80 buy = 1;	
	#10 buy = 0;
	#80 return_coins = 1;
	#10 return_coins = 0;
	#2000;
	#5000; $finish;	
	
	end


endmodule

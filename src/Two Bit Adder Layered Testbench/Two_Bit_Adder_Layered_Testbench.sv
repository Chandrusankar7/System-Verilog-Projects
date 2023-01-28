///////////////////////////////////////////////////////////////////
//Module: mem_if
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for interfacing all the signals in the system

interface mem_if(input bit clk);
logic rst; //Declaring all the signals as logic
logic rd_en, wr_en;
logic [3:0] addr;
logic [7:0] data_in;
logic [7:0] data_out;
logic [7:0] memory[16];
endinterface

///////////////////////////////////////////////////////////////////
//Module: ram
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for declaring the RAM memory functionalities such as read and write
module ram (mem_if memif);
int i,j; //Declaring integer values for assinging vales to meory
always@ (posedge memif.clk or posedge memif.rst)
begin

if (memif.rst)
begin
memif.data_out=0;

for (i=0;i<16;i++)
begin
for (j=0;j<16;j++)
memif.memory[i][j]=0;
end
end

else 
begin
if ((memif.rd_en ==1'b1) && (memif.wr_en==1'b0)) //Read operation
memif.data_out <= memif.memory[memif.addr];

else if ((memif.wr_en==1'b1) && (memif.rd_en==1'b0)) //Write operation
memif.memory[memif.addr] <= memif.data_in;
end
end
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_if
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for interfacing all the signals in the system
program mem_tb(mem_if memif);//calls the interface block in the testbench

initial begin
	memif.rst=1'b1;
	#5;
	memif.rst=1'b0;
	#5;
	$display("Data reading and writing using normal interface module");
	memif.wr_en =1;//asserting high to wr_en and making rd_en as zero
	memif.rd_en =0;
	memif.addr =4'b0110;//assinging the write_address 
	memif.data_in = 8'b10101010;//input data
	$display("@Time%0d: write_address = 0110", $time);//display the time of request
	$display("@Time%0d: write_data = 01010101", $time);//display the time of request
	#10;
	memif.rd_en =1;//asserting high to rd_en and making wr_en as zero
	memif.wr_en =0;
	memif.addr =4'b0110;//assinging the read_address 
	$display("@Time%0d: read_address = 0110", $time);//display the time of request
	$display("@Time%0d,: read_data =%0d", $time, memif.memory[memif.addr]);//display the time of request
	memif.wr_en =1;//asserting high to wr_en and making rd_en as zero
	memif.rd_en =0;
	memif.addr =4'b0111;//assinging the write_address 
	memif.data_in = 8'b10010010;//input data
	$display("@Time%0d: write_address = 0111", $time);//display the time of request
	$display("@Time%0d: write_data = 01010101", $time);//display the time of request
	#10;
	memif.rd_en =1;//asserting high to rd_en and making wr_en as zero
	memif.wr_en =0;
	memif.addr =4'b0111;//assinging the read_address 
	$display("@Time%0d: read_address = 0111", $time);//display the time of request
	$display("@Time%0d,: read_data =%0d", $time, memif.memory[memif.addr]);//display the time of request
	end
endprogram

///////////////////////////////////////////////////////////////////
//Module: mem_monitor
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for monitoring all the signals in the system. All the signals are provided as input to this module
module mem_monitor(mem_if memif);

	always@(posedge memif.wr_en)begin//write enable
		$display("@%0d: writing started",$time);//display the time of writing
		$display("@%0d: writing memory address %0d",$time,memif.addr);//display the writing address
		$display("@%0d: data writing in memory is %0d",$time,memif.data_in);//display the data get written in memory
		
		
	end

	always@(posedge memif.rd_en)begin//read starts
		$display("@%0d: reading started",$time);//display the time of writing
		$display("@%0d: reading memory address %0d",$time,memif.addr);//display the writing address
		$display("@%0d: data reading from memory is %0d",$time,memif.data_out);//display the data get written in memory
	end
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_top
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is the top level module used in the system
module mem_top;
bit clk;
always begin
clk=1'b1;
#10;
clk=1'b0;
#10;
end
mem_if memif (clk);
ram a1(memif);
mem_tb t1(memif);
mem_monitor m1(memif);
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_if
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for interfacing all the signals in the system with mod port
interface mem_if_mod(input bit clk);
logic rst; //Declaring all the signals as logic
logic rd_en, wr_en;
logic [3:0] addr;
logic [7:0] data_in;
logic [7:0] data_out;
logic [7:0] memory[16];
modport DUT (input rst, clk, rd_en, wr_en, addr, data_in, output data_out, memory); //Declaring clk and rst as input to DUT through mod port
modport tb (input data_out, memory, clk, output rst, rd_en, wr_en, addr, data_in); //Declaring clk as input and rst as output to DUT through mod port
modport mont (input rst, clk, rd_en, wr_en, addr, data_in, data_out, memory); //Declaring rst as input an to DUT through mod port
endinterface

///////////////////////////////////////////////////////////////////
//Module: ram_mod
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for declaring the RAM memory functionalities such as read and write
module ram_mod (mem_if_mod.DUT memif);
int i,j; //Declaring integer values for assinging vales to meory
always@ (posedge memif.clk or posedge memif.rst)
begin

if (memif.rst)
begin
memif.data_out=0;

for (i=0;i<16;i++)
begin
for (j=0;j<16;j++)
memif.memory[i][j]=0;
end
end

else 
begin
if ((memif.rd_en ==1'b1) && (memif.wr_en==1'b0)) //Read operation
memif.data_out = memif.memory[memif.addr];

else if ((memif.wr_en==1'b1) && (memif.rd_en==1'b0)) //Write operation
memif.memory[memif.addr] = memif.data_in;
end
end
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_if_mod
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for interfacing all the signals in the system
program mem_tb_mod(mem_if_mod.tb memif);//calls the interface block in the testbench

initial begin
$display("Data reading and writing using interface module and mod port");
	memif.wr_en =1;//asserting high to wr_en and making rd_en as zero
	memif.rd_en =0;
	memif.addr =4'b0110;//assinging the write_address 
	memif.data_in = 8'b10101010;//input data
	$display("@Time%0d: write_address = 0110", $time);//display the time of request
	$display("@Time%0d: write_data = 10101010", $time);//display the time of request
	#10;
	memif.rd_en =1;//asserting high to rd_en and making wr_en as zero
	memif.rd_en =0;
	memif.addr =4'b0110;//assinging the read_address 
	$display("@Time%0d: read_address = 0110", $time);//display the time of request
	$display("@Time%0d,: read_data =%0d", $time, memif.memory[memif.addr]);//display the time of request
	memif.wr_en =1;//asserting high to wr_en and making rd_en as zero
	memif.rd_en =0;
	memif.addr =4'b0111;//assinging the write_address 
	memif.data_in = 8'b10010010;//input data
	$display("@Time%0d: write_address = 0111", $time);//display the time of request
	$display("@Time%0d: write_data = 10010010", $time);//display the time of request
	#10;
	memif.rd_en =1;//asserting high to rd_en and making wr_en as zero
	memif.rd_en =0;
	memif.addr =4'b0111;//assinging the read_address 
	$display("@Time%0d: read_address = 0111", $time);//display the time of request
	$display("@Time%0d,: read_data =%0d", $time, memif.memory[memif.addr]);//display the time of request
	end
endprogram

///////////////////////////////////////////////////////////////////
//Module: mem_monitor_mod
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for monitoring all the signals in the system. All the signals are provided as input to this module
module mem_monitor_mod(mem_if_mod.mont memif);

	always@(posedge memif.wr_en)begin//write enable
		$display("@%0d: writing started",$time);//display the time of writing
		$display("@%0d: writing memory address %0d",$time,memif.addr);//display the writing address
		$display("@%0d: data writing in memory is %0d",$time,memif.data_in);//display the data get written in memory
		
		
	end

	always@(posedge memif.rd_en)begin//read starts
		$display("@%0d: reading started",$time);//display the time of writing
		$display("@%0d: reading memory address %0d",$time,memif.addr);//display the writing address
		$display("@%0d: data reading from memory is %0d",$time,memif.data_out);//display the data get written in memory
	end
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_top_mod
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is the top level module used in the system
module mem_top_mod;
bit clk;
always #5 clk=~clk;
mem_if_mod memif (clk);
ram_mod a1(memif);
mem_tb_mod t1(memif);
mem_monitor_mod m1(memif);
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_if_clk
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for interfacing all the signals in the system with mod port and clocking block
interface mem_if_clk(input bit clk);
logic rst; //Declaring all the signals as logic
logic rd_en, wr_en;
logic [3:0] addr;
logic [7:0] data_in;
logic [7:0] data_out;
logic [7:0] memory[16];

clocking cb @(posedge clk);
input data_out;
output rd_en, wr_en, addr, data_in;
default input #1 output #2;
endclocking

modport DUT (input rst, clk, rd_en, wr_en, addr, data_in, output data_out, memory); //Declaring clk and rst as input to DUT through mod port
modport tb (clocking cb, input clk, memory, output rst); //Declaring same variables of clocking block to testbench module
modport mont (input rst, clk, rd_en, wr_en, addr, data_in, data_out, memory); //Declaring rst as input an to DUT through mod port

endinterface

///////////////////////////////////////////////////////////////////
//Module: ram_clk
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for declaring the RAM memory functionalities such as read and write
module ram_clk (mem_if_clk.DUT memif);
int i,j; //Declaring integer values for assinging vales to meory
always@ (posedge memif.clk or posedge memif.rst)
begin

if (memif.rst)
begin
memif.data_out=0;

for (i=0;i<16;i++)
begin
for (j=0;j<16;j++)
memif.memory[i][j]=0;
end
end

else 
begin
if ((memif.rd_en ==1'b1) && (memif.wr_en==1'b0)) //Read operation
memif.data_out <= memif.memory[memif.addr];

else if ((memif.wr_en==1'b1) && (memif.rd_en==1'b0)) //Write operation
memif.memory[memif.addr] <= memif.data_in;
end
end
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_tb_clk
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for providing testbench values
program mem_tb_clk(mem_if_clk.tb memif);//calls the interface block in the testbench

initial begin
	@(posedge memif.clk)
	begin
	memif.rst<=1'b1;
	#5;
	memif.rst<=1'b0;
	#5;
	memif.cb.wr_en <= 1;//asserting high to wr_en and making rd_en as zero
	memif.cb.rd_en <= 0;
	memif.cb.addr <= 4'b0110;//assinging the write_address 
	memif.cb.data_in <= 8'b10101010;//input data
	$display("@%0d: write_address = 0110", $time);//display the time of request
	$display("@%0d: write_data = 10101010", $time);//display the time of request
	#10;
	memif.cb.rd_en <=1;//asserting high to rd_en and making wr_en as zero
	memif.cb.rd_en <=0;
	memif.cb.addr <=4'b0110;//assinging the read_address 
	$display("@%0d: read_address = 0010", $time);//display the time of request
	$display("@%0d,: read_data =%0d", $time, memif.memory[memif.cb.addr]);//display the time of request

		memif.rst<=1'b1;
	#5;
	memif.rst<=1'b0;
	#5;
	memif.cb.wr_en <= 1;//asserting high to wr_en and making rd_en as zero
	memif.cb.rd_en <= 0;
	memif.cb.addr <= 4'b0111;//assinging the write_address 
	memif.cb.data_in <= 8'b10010010;//input data
	$display("@%0d: write_address = 0111", $time);//display the time of request
	$display("@%0d: write_data = 10010010", $time);//display the time of request
	#10;
	memif.cb.rd_en <=1;//asserting high to rd_en and making wr_en as zero
	memif.cb.rd_en <=0;
	memif.cb.addr <=4'b0111;//assinging the read_address 
	$display("@%0d: read_address = 0111", $time);//display the time of request
	$display("@%0d,: read_data =%0d", $time, memif.memory[memif.cb.addr]);//display the time of request
	end
	end
endprogram

///////////////////////////////////////////////////////////////////
//Module: mem_monitor_clk
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module used for monitoring all the signals in the system. All the signals are provided as input to this module
module mem_monitor_clk(mem_if_clk.mont memif);

	always@(posedge memif.wr_en)begin//write enable
		$display("@%0d: writing started",$time);//display the time of writing
		$display("@%0d: writing memory address %0d",$time,memif.addr);//display the writing address
		$display("@%0d: data writing in memory is %0d",$time,memif.data_in);//display the data get written in memory
		
		
	end

	always@(posedge memif.rd_en)begin//read starts
		$display("@%0d: reading started",$time);//display the time of writing
		$display("@%0d: reading memory address %0d",$time,memif.addr);//display the writing address
		$display("@%0d: data reading from memory is %0d",$time,memif.data_out);//display the data get written in memory
	end
endmodule

///////////////////////////////////////////////////////////////////
//Module: mem_top_clk
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is the top level module used in the system
module mem_top_clk;
bit clk;
always #5 clk=~clk;
mem_if_clk memif (clk);
ram_clk a1(memif);
mem_tb_clk t1(memif);
mem_monitor_clk m1(memif);
endmodule
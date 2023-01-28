///////////////////////////////////////////////////////////////////
//Module: Question_one
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for declaring and assigning values for all types of data types used in system
verilog
module question_one();
initial begin
byte a=8'b1; //Creating a byte variable and assigning a binary value 1
shortint b=8'hab; //Creating a 16 bit variable using short int and assigning a hexadecimal value
ab
int c=32'habcd; //int data type is used for creating a 32 bit variable a value abcd is assigned to it
longint d=64'b1; //variables of integer type long int has 64 bit size
bit [31:0] e=32'hff; //Only bit is unsigned data type in system verilog, creating a 32 bit variable
int data_q[$]; //Creating a queue of name data_q
int addr_q[$]; //Creating a queue of name addr_q
int data_mem [bit [7:0] ]; //Declaring an associative array of int data type and indexing with 8 bit
value
$display ("a=%h, b=%h, c=%h, d=%h, e=%h", a, b, c, d, e); //Displaying all the created variables
end
endmodule


Question two code:
///////////////////////////////////////////////////////////////////
//Module: Question_two
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for practicing basic dynamic array operations
module question_two();
int dyn_array[]; //Creating a dynamic array dyn_array
int result; //Creating a variable result for storing the sum of elements in the array
initial
begin
result=0;
dyn_array=new[10]; //Increasing the size of array to 10 for adding 10 elements using an object
new
foreach(dyn_array[i])
dyn_array[i]=$urandom_range(25,0); //Assigning random value for the array from 0 to
25

foreach(dyn_array[i]) //Displaying the elements of array
$display ("dyn_array[%d] = %d", i, dyn_array[i]);

result=dyn_array.sum(); //Using array function sum() to find the sum of arrays and assigning it to
variable result
$display ("Sum of arrays = %d", result);
dyn_array.sort(); //Sorting the array using array function sort()
$display ("Sorted array:");

foreach(dyn_array[i]) //Displaying the sorted array
$display ("dyn_array[%d] = %d", i, dyn_array[i]);

end
endmodule


Question three code:
///////////////////////////////////////////////////////////////////
//Module: Question_three
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for performing queue operations
module question_three_queue ();
int data_q[$]; //Creating a queue data_q
int addr_q[$]; //Creating a queue addr_q
initial
begin
data_q.push_front(5); //Pushing new values in the front of queue
data_q.push_front(7);
data_q.push_front(2);
data_q.push_front(4);

$display ("size of array = %d", data_q.size()); //displaying the Size of the queue

$display ("The elements of array:"); //displaying the Elements of the queue
foreach (data_q[i])
$display ("%d", data_q[i]);

$display ("Popping the front element:"); //Popping Front element of the queue
$display ("%d", data_q.pop_front());
$display ("Array after popping the front element:"); //Displaying queue after popping front
element
foreach (data_q[i])
$display ("%d", data_q[i]);

$display ("Deleting element at address 3:"); // Deleting the element at location 2
data_q.delete(2);
foreach (data_q[i])
$display ("%d", data_q[i]);

for (int j=0;j<10;j=j+1) // Assigning random values from 0 to 25 for the queue addr_q
addr_q[j]=$urandom_range(25,0);

$display ("Address queue");
foreach (addr_q[i])
$display ("%d", addr_q[i]); //Displaying queue

end
endmodule


Question four code:

///////////////////////////////////////////////////////////////////
//Module: Question_four
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for performing associative array operations such as assigning data, displaying
front, last elements
module question_four();
int unsigned addr_q[$]={}; //Declaring a queue addr_q
int associative_arr[int];// Declarations of associative array
int unsigned f; //Creating unsigned integers for getting the first and last element of the
associative array
int unsigned l;
int i=0;

//Creating 10 random address
initial
begin
repeat(10)
begin
addr_q[i]=$urandom_range(25,0);
i=i+1;
end
$display("Random Address:%p", addr_q);
end

//Creating Associative array with random data present in addr_q as its address
initial
begin
repeat(10)
begin
associative_arr[addr_q.pop_front()]=$urandom_range(25,0);
end

//Displaying associative array elements
foreach(associative_arr[i])
begin
$display("Array elements:%d", associative_arr[i]);
end
end

//Displaying the First index and first element by using first() function
initial
begin
if(associative_arr.first(f)==1);
$display("First index value:%h, Value at 1st index:%d", f, associative_arr[f]);
end

//Display last index and last element by using last() function
initial
begin
if(associative_arr.last(l)==1);
$display("Last index value:%h, Value at last index:%d", l, associative_arr[l]);
end
endmodule


Question five code:
///////////////////////////////////////////////////////////////////
//Module: Question_five
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for displaying the pixel data of respective colors using user defined data type
module question_five_typedef();
typedef struct packed {bit[7:0] red,green,blue;}pixels; // creating a typedef data type variable
pixel containing variables reg, green, blue each of 8 bits sice pixel values are upto 255
pixels pix1; // Creating 5 pixels for storing 5 colors
pixels pix2;
pixels pix3;
pixels pix4;
pixels pix5;
int i;
bit [4:0] [2:0] [7:0]pixel_array; // Created a pixel array for storing 5 pixel colors containing three
variables of 8 bit data

initial
begin
//Pixel1-Red
pix1.red=8'd255; pix1.green=8'd0; pix1.blue=8'd0;
//Pixel2-Violet
pix2.red=8'd204; pix2.green=8'd51; pix2.blue=8'd255;
//Pixel3-Pink
pix3.red=8'd255; pix3.green=8'd0; pix3.blue=8'd255;
//Pixel4-Brown
pix4.red=8'd153; pix4.green=8'd51; pix4.blue=8'd51;
//Pixel5-Cean
pix5.red=8'd102; pix5.green=8'd255; pix5.blue=8'd255;
end

initial //Assigning colos to the pixel array
begin
pixel_array[0]=pix1;
pixel_array[1]=pix2;
pixel_array[2]=pix3;
pixel_array[3]=pix4;
pixel_array[4]=pix5;

foreach(pixel_array[i]) //Displaying pixel values for corresponding colors
begin
$display("Pixel Value of color number %d:[%d]",i,pixel_array[i]);
end
end
endmodule


Question six code:
///////////////////////////////////////////////////////////////////
//Module: Question_six
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a module for 010 sequence detector using enum data type
module question_six(clk, rst, ser_in, seqout);
input clk,rst; Declaring clock, rst and ser_in as inputs
input ser_in;
output reg seqout; //Declaring seqout as output
typedef enum {idle, got0, got01, got010} states; //Creating an enumerated data type "states" of
values idel, got0, got01, got010

states ps, ns;

always@(posedge clk or posedge rst)
begin
if(rst) //Making seqout as 0 and present state as idle when reset is active
begin
seqout=1'b0;
ps<=idle;
end
else if(clk) //Making state transition of assigning next state to present state if reset is not active
ps<=ns;
end

always@ (ps or ser_in)
begin
case(ps) //Making switch cases based on the state diagram for 010 detector
idle:begin
if(ser_in==1'b0)
ns<=got0;

else
ns<=idle;
end
got0:begin
if(ser_in==1'b1)
ns<=got01;

else
ns<=got0;
end
got01:begin
if(ser_in==1'b0)
begin
ns<=got010;
end

else
ns<=idle;
end
got010:begin
if(ser_in==1'b0)
ns<=got0;

else
ns<=got01;
end
endcase

$display("Nest state: %0s", ns.name); //Displaying the current next state values
end

always@(ps)
begin
case(ps)
idle: seqout<=1'b0; //making seqoutt value as one only on got010 state
got0: seqout<=1'b0;
got01: seqout<=1'b0;
got010: seqout<=1'b1;
endcase
end

endmodule

///////////////////////////////////////////////////////////////////
//Module: tb_question_six
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
//Description:
//This is a testbench module for 010 sequence detector using enum data type
module tb_question_six();
reg clk, rst;
reg ser_in;
wire seqout;

initial
begin
rst=1'b1;
#10;
rst=1'b0;
end

always //Creating a clock of 20ns time period and 10 ns on time
begin
clk=1'b1;
#10;
clk=1'b0;
#10;
end

always@ (posedge clk)
begin
ser_in<=$random; //Generating random values on each clock cycle
end

question_six inst0(.clk(clk),.rst(rst),.ser_in(ser_in),.seqout(seqout));
endmodule


Question seven code:
///////////////////////////////////////////////////////////////////
//Module: Question_seven
//Project: MTech-VLSI-Verilog_SystemVerilog_Lab_Assignment
Honour Pledge: I affirm that I will not give or receive any unauthorized help on this lab, and that all work
will be my own

21VL684: Functional Verification Lab Mar-July 2022
//Description:
//This is a module for performing three basic string operations using system verilog
module question_seven ();

initial
begin
string c; //Declaring a string C
c="Chandra"; //Initializing a value to the string
$display ("String: %s", c); //Displaying the string

$display ("The 0th index of the string is: %c", c.getc(0)); //Displaying the character at 0th index
in the string

$display ("Length of the string is %d",c.len()); //Displaying the length of the string

$display ("Converting all the characters in the string to uppercase: %s", c.toupper());
//Displaying the strig after converting the characters into uppercase

c.putc(6,"u");
$display ("Replacing the 6th element of the string with another letter: %s", c);//Replacing a
character in the string using putc
end
endmodule
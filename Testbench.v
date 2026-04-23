`timescale 1ns / 1ps

module tb_Dff();
reg D_ti; 
reg clk_ti;
wire Q_to; 
wire Qbar_to;

//net(s)
integer count;
integer pass;
integer fail;
reg exp_Q;
reg exp_Qbar;
reg D_pre;

//instantiation
Dff UUT(.D_i(D_ti), 
   .clk_i(clk_ti), 
   .Q_o(Q_to), 
   .Qbar_o(Qbar_to));

//initialization
initial begin
count = 0;
pass = 0;
fail = 0;
end

//capture
initial begin
$monitor("Time: %0t | D: %b, Clock: %b | Q: %b, Qn: %b", $time, D_ti, clk_ti, Q_to, Qbar_to);
$dumpfile("Dff.vcd");
$dumpvars(0, tb_Dff);
end

//clock
initial begin
   clk_ti = 1'b0;
   repeat(20)
      #5 clk_ti = ~clk_ti;
end

//feeding 
initial begin
   D_ti = 1'b0;      //t=0, low clk
   #1 check;
   #4 D_ti = 1'b1;   //5, rising clk
   #1 check;
   #2 D_ti = 1'b0;   //8, high clk
   #1 check;
   #5 D_ti = 1'b1;   //14, low clk
   #1 check; 
      D_ti = 1'b0;   //15, rising clk
   #1 check;
   #2 D_ti = 1'b1;   //18, high clk
   #1 check;
   #1 D_ti = 1'b0;   //20, falling clk
   #1 check;
   #9 D_ti = 1'b1;   //30, falling clk
   #1 check;
   #2 $display("Checks: %d, | Pass: %d, Fail: %d", count, pass, fail);
   #7 $finish;
end //checks may be syncronized after each posedge, clean code

always@(posedge clk_ti)
   D_pre <= D_ti; 
   
//self check -- may include bug for new design, i'll fix later: initialize check;, make it for posedge clk;
task check(); begin
exp_Q = D_pre;
exp_Qbar = ~D_pre;
if((exp_Q !== Q_to) || (exp_Qbar !== Qbar_to)) begin
   $display("Error | Time: %0t | D: %b, Clock: %b | Q: %b, Qn: %b | Exp Q: %b, Qn: %b", $time, D_ti, clk_ti, Q_to, Qbar_to, exp_Q, exp_Qbar);
   fail = fail + 1;
end
else
   pass = pass + 1;
count = count + 1;
end
endtask

endmodule

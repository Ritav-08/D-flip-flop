`timescale 1ns / 1ps

module Dff(
   input D_i, 
   input clk_i, 
   output reg Q_o, 
   output Qbar_o
);

assign Qbar_o = ~Q_o;
always@(posedge clk_i)
   Q_o <= D_i;

endmodule

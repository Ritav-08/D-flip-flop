`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2026 18:00:48
// Design Name: 
// Module Name: Dff
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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

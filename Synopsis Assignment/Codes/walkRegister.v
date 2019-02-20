`timescale 1ns/1ps

module walkRegister(clk,g_reset,WR_Sync,WR_Reset,WR_Out);
    
    input clk,g_reset;
    input WR_Sync,WR_Reset;
    output reg WR_Out;

    always @(posedge clk, posedge g_reset) begin
        if (WR_Reset | !g_reset) WR_Out = 0;
        else if(WR_Sync) WR_Out = 1;
    end

endmodule

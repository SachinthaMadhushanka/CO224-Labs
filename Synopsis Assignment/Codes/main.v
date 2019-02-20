`include "time_param.v"
`include "timer.v"
`include "walkRegister.v"
`include "debounce.v"
`include "divider.v"
`include "fsm.v"
`include "labkit.v"
`include "synchronizer.v"

module main();
	
	wire clk_out;
	reg clk,rst,sensor,walk_request,reprogram,g_reset,sensor_sync,WR_Out,prog_sync,expired;
    reg [1:0] time_parameter_selector;

    wire start_timer,out,WR_Reset;
    wire [1:0] interval;
    wire [6:0] lights;
    wire [6:0] leds;
    wire [3:0] value;

    fsm fsm1(clk,g_reset,sensor_sync,WR_Out,prog_sync,expired,WR_Reset,interval,start_timer,lights);
	synchronize syncMod(clk,g_reset,in,out);
    labkit labkitMod(clk,g_reset,sensor,walk_request,reprogram,time_parameter_selector,time_value,leds);
    time_para time_para1(clk,g_reset,prog_sync,param_selector,time_value,interval,value);
    timer t1(clk,g_reset,value,start_timer,expired);
    divider d1(clk,rst,clk_out);
    walkRegister w1(clk,g_reset,WR_Sync,WR_Reset,WR_Out);
    debounce debounce1(g_reset, clk, noisy, clean);
	
	initial begin
	
		$dumpfile("main.vcd");
		$dumpvars(0, main);
	
		clk = 0;
		#1 rst = 0;
		#1 rst = 1;
        clk         <= 0;
        g_reset     <= 1;
        sensor_sync <= 0;
        WR_Out      <= 0;
        prog_sync   <= 0;

        #1 g_reset = 0;
        #3 g_reset = 1;

        #50 WR_Out = 1;
		
		
		
		
		$display("finish");
		
	    #200 $finish();
		
	end
	
	initial forever #1 clk = ~clk;

    initial forever begin 
        #10 expired = 1;
        #2 expired  = 0;
    end

endmodule
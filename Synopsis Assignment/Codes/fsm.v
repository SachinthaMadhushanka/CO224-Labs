module fsm(clk,g_reset,sensor_sync,WR_Out,prog_sync,expired,WR_Reset,interval,start_timer,lights);

    parameter s1 = 3'd1,s2 = 3'd2,s3 = 3'd3,s4 = 3'd4,s5 = 3'd5,s6 = 3'd6,s7 = 3'd7;
    parameter n = 3'd0;
    parameter tBase = 2'b00, tExt = 2'b01, tYel = 2'b10, tZero = 2'b11;

    input sensor_sync,WR_Out,expired,clk,g_reset,prog_sync;
    output reg WR_Reset,start_timer;
    output reg [1:0] interval;
    output reg [6:0] lights;

    reg [2:0] next_state,current_state;    
       
   
    always @ (posedge clk) begin

        if (!g_reset)begin
            current_state   <= s1;
            next_state      <= s1;
            lights          <= 7'd0;
            start_timer     <= 1;


        end else if (current_state == next_state) begin
            case(current_state)
                s1: begin
                        next_state <= s2;
                        interval <= tBase;
                    end
                s2: begin
                        next_state <= s3;
                        if(sensor_sync) interval <= tExt;
                        else interval <= tBase;
                    end
                s3: begin
                        if(WR_Out)begin
                            next_state <= s7;
                            WR_Reset = 1;
                        end else next_state <= s4;
                        interval <= tYel;
                    end
                s4: begin
                        next_state <= s5;
                        interval <= tBase;
                    end
                s5: begin
                        next_state <= s6;
                        if(sensor_sync)interval <= tExt;
                        else interval <= tZero;
                    end
                s6: begin
                        next_state <= s1;
                        interval <= tYel;
                    end
                s7: begin
                        next_state <= s4;
                        interval <= tExt;
                    end
            endcase
        end else begin
            start_timer = 0;
            WR_Reset = 0;
        end

    end


    always @ (posedge expired) begin
        current_state = next_state;
        start_timer = 1;
    end

    always @ (*) begin
        case (current_state)            
            s1: lights = 7'b1100111;
            s2: lights = 7'b1100111;
            s3: lights = 7'b1010111;
            s4: lights = 7'b0111101;
            s5: lights = 7'b0111101;
            s6: lights = 7'b0111011;
            s7: lights = 7'b0110110;
        endcase
    end

endmodule

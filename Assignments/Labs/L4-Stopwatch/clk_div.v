`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:57:49 05/03/2017
// Design Name:
// Module Name:    clk_div
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
//TODO: Figure out how fast to make blink_clk blink
module clk_div(
    //Input
    sys_clk, rst,
    //Ouput
    onehz_clk, twohz_clk, fast_clk, blink_clk
    );
// Master clock: 100 MHz
input sys_clk;
input rst;

// 1 Hz clock
// 100,000,000 clock cycles for onehz_clk to go high and return to low
// Thus, it takes half (i.e. 50,000,000) for onehz_clk to go high
output wire onehz_clk;
reg onehz_clk_temp;
// 2 Hz clock
// 50,000,000 clock cycles for twohz_clk to go high and return to low
// Thus, it takes half (i.e. 25,000,000) for twohz_clk to go high
output wire twohz_clk;
reg twohz_clk_temp;
// 400 Hz clock
// 250,000 clock cycles for fasthz_clk to go high and return to low
// Thus, it takes half (i.e. 125,000) for fasthz_clk to go high
output wire fast_clk;
reg fast_clk_temp;
// 4 Hz clock
// 25,000,000 clock cycles for blinkhz_clk to go high and return to low
// Thus, it takes half (i.e. 12,500,000) for blinkhz_clk to go high
output wire blink_clk;
reg blink_clk_temp;

// Counters to count the clock cycles before the specified clock goes high
reg [31:0] onehz_count;
reg [31:0] twohz_count;
reg [31:0] fasthz_count;
reg [31:0] blinkhz_count;

    // 1 Hz Clock Implementation
    always @ (posedge sys_clk or posedge rst) begin
        if (rst == 1'b1) begin
            onehz_count <= 32'b0;
            onehz_clk_temp <= 1'b0;
        end
        else if (onehz_count == 32'd50000000 - 32'b1) begin
            onehz_count <= 32'b0;
            onehz_clk_temp <= ~onehz_clk;
        end
        else begin
            onehz_count <= onehz_count + 32'b1;
            onehz_clk_temp <= onehz_clk;
        end
    end
    // 2 Hz Clock Implementation
    always @ (posedge sys_clk or posedge rst) begin
        if (rst == 1'b1) begin
            twohz_count <= 32'b0;
            twohz_clk_temp <= 1'b0;
        end
        else if (twohz_count == 32'd25000000 - 32'b1) begin
            twohz_count <= 32'b0;
            twohz_clk_temp <= ~twohz_clk;
        end
        else begin
            twohz_count <= twohz_count + 32'b1;
            twohz_clk_temp <= twohz_clk;
        end
    end
    // Fast (400 Hz) Clock Implementation
    always @ (posedge sys_clk or posedge rst) begin
        if (rst == 1'b1) begin
            fasthz_count <= 32'b0;
            fast_clk_temp <= 1'b0;
        end
        else if (fasthz_count == 32'd125000 - 32'b1) begin
            fasthz_count <= 32'b0;
            fast_clk_temp <= ~fast_clk;
        end
        else begin
            fasthz_count <= fasthz_count + 32'b1;
            fast_clk_temp <= fast_clk;
        end
    end
    // Blink (4 Hz) Clock Implementation
    always @ (posedge sys_clk or posedge rst) begin
        if (rst == 1'b1) begin
            blinkhz_count <= 32'b0;
            blink_clk_temp <= 1'b0;
        end
        else if (blinkhz_count == 32'd12500000 - 32'b1) begin
            blinkhz_count <= 32'b0;
            blink_clk_temp <= ~blink_clk;
        end
        else begin
            blinkhz_count <= blinkhz_count + 32'b1;
            blink_clk_temp <= blink_clk;
        end
    end
	 
	 assign onehz_clk = onehz_clk_temp;
	 assign twohz_clk = twohz_clk_temp;
	 assign fast_clk = fast_clk_temp;
	 assign blink_clk = blink_clk_temp;
	 
endmodule
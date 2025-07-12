`timescale 1ns / 1ps

module fir_tb;

    reg clk, reset;
    reg signed [7:0] x_in;
    wire signed [15:0] y_out;

    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    integer i;

    reg signed [7:0] input_signal [0:9];

    initial begin
        input_signal[0] = 8'd10;
        input_signal[1] = 8'd20;
        input_signal[2] = 8'd30;
        input_signal[3] = 8'd40;
        input_signal[4] = 8'd50;
        input_signal[5] = 8'd40;
        input_signal[6] = 8'd30;
        input_signal[7] = 8'd20;
        input_signal[8] = 8'd10;
        input_signal[9] = 8'd0;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, fir_tb);

        clk = 0;
        reset = 1;
        x_in = 0;
        #10 reset = 0;

        for (i = 0; i < 10; i = i + 1) begin
            x_in = input_signal[i];
            #10;
        end

        #50 $finish;
    end

    always #5 clk = ~clk;

endmodule

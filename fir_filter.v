module fir_filter (
    input clk,
    input reset,
    input signed [7:0] x_in,
    output reg signed [15:0] y_out
);
    parameter N = 4;

    reg signed [7:0] x [0:N-1];
    reg signed [7:0] h [0:N-1];

    integer i;

    initial begin
        // Example coefficients for a low-pass filter
        h[0] = 8'd1;
        h[1] = 8'd2;
        h[2] = 8'd2;
        h[3] = 8'd1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < N; i = i + 1) x[i] <= 0;
            y_out <= 0;
        end else begin
            for (i = N-1; i > 0; i = i - 1)
                x[i] <= x[i-1];
            x[0] <= x_in;

            y_out <= 0;
            for (i = 0; i < N; i = i + 1)
                y_out <= y_out + x[i] * h[i];
        end
    end

endmodule

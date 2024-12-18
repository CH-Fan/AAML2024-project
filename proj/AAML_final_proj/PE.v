module PE (
    clk,
    rst_n,
    pe_rst,
    left_in,
    top_in,
    pe_rst_seq,
    right_out,
    bottom_out,
    acc
);

// IO
input clk, rst_n;
input pe_rst;
input signed [8:0] left_in;
input signed [7:0] top_in;

output reg pe_rst_seq;
output reg signed [8:0] right_out;
output reg signed [7:0] bottom_out;
output reg signed [31:0] acc;

// Signal
reg signed [17:0] mul;
reg signed [31:0] add_acc;
reg signed [31:0] acc_comb;

// Design
always @(posedge clk) begin
    if (!rst_n) begin
        pe_rst_seq <= 0;
        right_out <= 0;
        bottom_out <= 0;
    end
    else begin
        pe_rst_seq <= pe_rst;
        right_out <= left_in;
        bottom_out <= top_in;
    end
end

always @(*) begin
    mul = right_out * bottom_out;
    add_acc = pe_rst_seq ? 'd0 : acc;
    acc_comb = add_acc + mul;
end

always @(posedge clk) begin
    if (!rst_n) acc <= 'd0;
    else acc <= acc_comb;
end


endmodule
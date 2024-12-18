`include "PE.v"

module SYS_16x16_ARRAY (
    clk,
    rst_n,
    in_valid,
    offset_valid,
    sys_rst_seq0,
    left,
    top,
    out_valid,
    row0_out,
    row1_out,
    row2_out,
    row3_out,
    row4_out,
    row5_out,
    row6_out,
    row7_out,
    row8_out,
    row9_out,
    row10_out,
    row11_out,
    row12_out,
    row13_out,
    row14_out,
    row15_out
);

// IO
input clk, rst_n;
input [15:0] in_valid;
input offset_valid;
input sys_rst_seq0;
input [127:0] left, top;

output reg [15:0] out_valid;
output wire [511:0] row0_out, row1_out, row2_out, row3_out, row4_out, row5_out, row6_out, row7_out, row8_out, row9_out, row10_out, row11_out, row12_out, row13_out, row14_out, row15_out;

// Signals
wire sys_rst_seq1, sys_rst_seq2, sys_rst_seq3, sys_rst_seq4, sys_rst_seq5, sys_rst_seq6, sys_rst_seq7, sys_rst_seq8, sys_rst_seq9;
wire sys_rst_seq10, sys_rst_seq11, sys_rst_seq12, sys_rst_seq13, sys_rst_seq14, sys_rst_seq15, sys_rst_seq16, sys_rst_seq17, sys_rst_seq18, sys_rst_seq19;
wire sys_rst_seq20, sys_rst_seq21, sys_rst_seq22, sys_rst_seq23, sys_rst_seq24, sys_rst_seq25, sys_rst_seq26, sys_rst_seq27, sys_rst_seq28, sys_rst_seq29, sys_rst_seq30, sys_rst_seq31;
wire [143:0] left_seq0, left_seq1, left_seq2, left_seq3, left_seq4, left_seq5, left_seq6, left_seq7, left_seq8, left_seq9, left_seq10, left_seq11, left_seq12, left_seq13, left_seq14, left_seq15,  right;
wire [127:0]             top_seq1,  top_seq2,  top_seq3,  top_seq4,  top_seq5,  top_seq6,  top_seq7,  top_seq8,  top_seq9,  top_seq10,  top_seq11,  top_seq12,  top_seq13,  top_seq14,  top_seq15, bottom;

wire signed [8:0] left_offset0 = offset_valid ? $signed(left[127:120]) + 128 : $signed(left[127:120]);
wire signed [8:0] left_offset1 = offset_valid ? $signed(left[119:112]) + 128 : $signed(left[119:112]);
wire signed [8:0] left_offset2 = offset_valid ? $signed(left[111:104]) + 128 : $signed(left[111:104]);
wire signed [8:0] left_offset3 = offset_valid ? $signed(left[103: 96]) + 128 : $signed(left[103: 96]);
wire signed [8:0] left_offset4 = offset_valid ? $signed(left[ 95: 88]) + 128 : $signed(left[ 95: 88]);
wire signed [8:0] left_offset5 = offset_valid ? $signed(left[ 87: 80]) + 128 : $signed(left[ 87: 80]);
wire signed [8:0] left_offset6 = offset_valid ? $signed(left[ 79: 72]) + 128 : $signed(left[ 79: 72]);
wire signed [8:0] left_offset7 = offset_valid ? $signed(left[ 71: 64]) + 128 : $signed(left[ 71: 64]);
wire signed [8:0] left_offset8 = offset_valid ? $signed(left[ 63: 56]) + 128 : $signed(left[ 63: 56]);
wire signed [8:0] left_offset9 = offset_valid ? $signed(left[ 55: 48]) + 128 : $signed(left[ 55: 48]);
wire signed [8:0] left_offset10= offset_valid ? $signed(left[ 47: 40]) + 128 : $signed(left[ 47: 40]);
wire signed [8:0] left_offset11= offset_valid ? $signed(left[ 39: 32]) + 128 : $signed(left[ 39: 32]);
wire signed [8:0] left_offset12= offset_valid ? $signed(left[ 31: 24]) + 128 : $signed(left[ 31: 24]);
wire signed [8:0] left_offset13= offset_valid ? $signed(left[ 23: 16]) + 128 : $signed(left[ 23: 16]);
wire signed [8:0] left_offset14= offset_valid ? $signed(left[ 15:  8]) + 128 : $signed(left[ 15:  8]);
wire signed [8:0] left_offset15= offset_valid ? $signed(left[  7:  0]) + 128 : $signed(left[  7:  0]);
assign left_seq0 = {left_offset0, left_offset1, left_offset2, left_offset3, left_offset4, left_offset5, left_offset6, left_offset7, left_offset8, left_offset9, left_offset10, left_offset11, left_offset12, left_offset13, left_offset14, left_offset15};

reg [15:0] out_valid_pp0, out_valid_pp1, out_valid_pp2, out_valid_pp3, out_valid_pp4, out_valid_pp5, out_valid_pp6, out_valid_pp7, out_valid_pp8, out_valid_pp9, out_valid_pp10, out_valid_pp11, out_valid_pp12, out_valid_pp13;

wire [31:0] arr_out [0:15][0:15];

// Design
// Signal naming is based on 0-indexing.
PE pe_0_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq0 ), .left_in(left_seq0 [143:135]), .top_in(     top [127:120]), .pe_rst_seq(sys_rst_seq1 ), .right_out(left_seq1 [143:135]), .bottom_out(top_seq1 [127:120]), .acc(arr_out[0][0] ));
PE pe_0_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq1 ), .left_in(left_seq1 [143:135]), .top_in(     top [119:112]), .pe_rst_seq(sys_rst_seq2 ), .right_out(left_seq2 [143:135]), .bottom_out(top_seq1 [119:112]), .acc(arr_out[0][1] ));
PE pe_0_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq2 ), .left_in(left_seq2 [143:135]), .top_in(     top [111:104]), .pe_rst_seq(sys_rst_seq3 ), .right_out(left_seq3 [143:135]), .bottom_out(top_seq1 [111:104]), .acc(arr_out[0][2] ));
PE pe_0_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq3 ), .left_in(left_seq3 [143:135]), .top_in(     top [103: 96]), .pe_rst_seq(sys_rst_seq4 ), .right_out(left_seq4 [143:135]), .bottom_out(top_seq1 [103: 96]), .acc(arr_out[0][3] ));
PE pe_0_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq4 ), .left_in(left_seq4 [143:135]), .top_in(     top [ 95: 88]), .pe_rst_seq(sys_rst_seq5 ), .right_out(left_seq5 [143:135]), .bottom_out(top_seq1 [ 95: 88]), .acc(arr_out[0][4] ));
PE pe_0_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq5 ), .left_in(left_seq5 [143:135]), .top_in(     top [ 87: 80]), .pe_rst_seq(sys_rst_seq6 ), .right_out(left_seq6 [143:135]), .bottom_out(top_seq1 [ 87: 80]), .acc(arr_out[0][5] ));
PE pe_0_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq6 ), .left_in(left_seq6 [143:135]), .top_in(     top [ 79: 72]), .pe_rst_seq(sys_rst_seq7 ), .right_out(left_seq7 [143:135]), .bottom_out(top_seq1 [ 79: 72]), .acc(arr_out[0][6] ));
PE pe_0_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7 ), .left_in(left_seq7 [143:135]), .top_in(     top [ 71: 64]), .pe_rst_seq(sys_rst_seq8 ), .right_out(left_seq8 [143:135]), .bottom_out(top_seq1 [ 71: 64]), .acc(arr_out[0][7] ));
PE pe_0_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8 ), .left_in(left_seq8 [143:135]), .top_in(     top [ 63: 56]), .pe_rst_seq(sys_rst_seq9 ), .right_out(left_seq9 [143:135]), .bottom_out(top_seq1 [ 63: 56]), .acc(arr_out[0][8] ));
PE pe_0_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9 ), .left_in(left_seq9 [143:135]), .top_in(     top [ 55: 48]), .pe_rst_seq(sys_rst_seq10), .right_out(left_seq10[143:135]), .bottom_out(top_seq1 [ 55: 48]), .acc(arr_out[0][9] ));
PE pe_0_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq10[143:135]), .top_in(     top [ 47: 40]), .pe_rst_seq(sys_rst_seq11), .right_out(left_seq11[143:135]), .bottom_out(top_seq1 [ 47: 40]), .acc(arr_out[0][10]));
PE pe_0_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq11[143:135]), .top_in(     top [ 39: 32]), .pe_rst_seq(sys_rst_seq12), .right_out(left_seq12[143:135]), .bottom_out(top_seq1 [ 39: 32]), .acc(arr_out[0][11]));
PE pe_0_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq12[143:135]), .top_in(     top [ 31: 24]), .pe_rst_seq(sys_rst_seq13), .right_out(left_seq13[143:135]), .bottom_out(top_seq1 [ 31: 24]), .acc(arr_out[0][12]));
PE pe_0_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq13[143:135]), .top_in(     top [ 23: 16]), .pe_rst_seq(sys_rst_seq14), .right_out(left_seq14[143:135]), .bottom_out(top_seq1 [ 23: 16]), .acc(arr_out[0][13]));
PE pe_0_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq14[143:135]), .top_in(     top [ 15:  8]), .pe_rst_seq(sys_rst_seq15), .right_out(left_seq15[143:135]), .bottom_out(top_seq1 [ 15:  8]), .acc(arr_out[0][14]));
PE pe_0_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq15[143:135]), .top_in(     top [  7:  0]), .pe_rst_seq(sys_rst_seq16), .right_out(     right[143:135]), .bottom_out(top_seq1 [  7:  0]), .acc(arr_out[0][15]));

PE pe_1_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq1 ), .left_in(left_seq0 [134:126]), .top_in(top_seq1 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [134:126]), .bottom_out(top_seq2 [127:120]), .acc(arr_out[1][0] ));
PE pe_1_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq2 ), .left_in(left_seq1 [134:126]), .top_in(top_seq1 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [134:126]), .bottom_out(top_seq2 [119:112]), .acc(arr_out[1][1] ));
PE pe_1_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq3 ), .left_in(left_seq2 [134:126]), .top_in(top_seq1 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [134:126]), .bottom_out(top_seq2 [111:104]), .acc(arr_out[1][2] ));
PE pe_1_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq4 ), .left_in(left_seq3 [134:126]), .top_in(top_seq1 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [134:126]), .bottom_out(top_seq2 [103: 96]), .acc(arr_out[1][3] ));
PE pe_1_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq5 ), .left_in(left_seq4 [134:126]), .top_in(top_seq1 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [134:126]), .bottom_out(top_seq2 [ 95: 88]), .acc(arr_out[1][4] ));
PE pe_1_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq6 ), .left_in(left_seq5 [134:126]), .top_in(top_seq1 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [134:126]), .bottom_out(top_seq2 [ 87: 80]), .acc(arr_out[1][5] ));
PE pe_1_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7 ), .left_in(left_seq6 [134:126]), .top_in(top_seq1 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [134:126]), .bottom_out(top_seq2 [ 79: 72]), .acc(arr_out[1][6] ));
PE pe_1_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8 ), .left_in(left_seq7 [134:126]), .top_in(top_seq1 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [134:126]), .bottom_out(top_seq2 [ 71: 64]), .acc(arr_out[1][7] ));
PE pe_1_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9 ), .left_in(left_seq8 [134:126]), .top_in(top_seq1 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [134:126]), .bottom_out(top_seq2 [ 63: 56]), .acc(arr_out[1][8] ));
PE pe_1_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq9 [134:126]), .top_in(top_seq1 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[134:126]), .bottom_out(top_seq2 [ 55: 48]), .acc(arr_out[1][9] ));
PE pe_1_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq10[134:126]), .top_in(top_seq1 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[134:126]), .bottom_out(top_seq2 [ 47: 40]), .acc(arr_out[1][10]));
PE pe_1_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq11[134:126]), .top_in(top_seq1 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[134:126]), .bottom_out(top_seq2 [ 39: 32]), .acc(arr_out[1][11]));
PE pe_1_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq12[134:126]), .top_in(top_seq1 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[134:126]), .bottom_out(top_seq2 [ 31: 24]), .acc(arr_out[1][12]));
PE pe_1_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq13[134:126]), .top_in(top_seq1 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[134:126]), .bottom_out(top_seq2 [ 23: 16]), .acc(arr_out[1][13]));
PE pe_1_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq14[134:126]), .top_in(top_seq1 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[134:126]), .bottom_out(top_seq2 [ 15:  8]), .acc(arr_out[1][14]));
PE pe_1_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq15[134:126]), .top_in(top_seq1 [  7:  0]), .pe_rst_seq(sys_rst_seq17), .right_out(     right[134:126]), .bottom_out(top_seq2 [  7:  0]), .acc(arr_out[1][15]));

PE pe_2_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq2),  .left_in(left_seq0 [125:117]), .top_in(top_seq2 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [125:117]), .bottom_out(top_seq3 [127:120]), .acc(arr_out[2][0] ));
PE pe_2_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq3),  .left_in(left_seq1 [125:117]), .top_in(top_seq2 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [125:117]), .bottom_out(top_seq3 [119:112]), .acc(arr_out[2][1] ));
PE pe_2_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq4),  .left_in(left_seq2 [125:117]), .top_in(top_seq2 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [125:117]), .bottom_out(top_seq3 [111:104]), .acc(arr_out[2][2] ));
PE pe_2_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq5),  .left_in(left_seq3 [125:117]), .top_in(top_seq2 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [125:117]), .bottom_out(top_seq3 [103: 96]), .acc(arr_out[2][3] ));
PE pe_2_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq6),  .left_in(left_seq4 [125:117]), .top_in(top_seq2 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [125:117]), .bottom_out(top_seq3 [ 95: 88]), .acc(arr_out[2][4] ));
PE pe_2_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7),  .left_in(left_seq5 [125:117]), .top_in(top_seq2 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [125:117]), .bottom_out(top_seq3 [ 87: 80]), .acc(arr_out[2][5] ));
PE pe_2_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8),  .left_in(left_seq6 [125:117]), .top_in(top_seq2 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [125:117]), .bottom_out(top_seq3 [ 79: 72]), .acc(arr_out[2][6] ));
PE pe_2_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq7 [125:117]), .top_in(top_seq2 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [125:117]), .bottom_out(top_seq3 [ 71: 64]), .acc(arr_out[2][7] ));
PE pe_2_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq8 [125:117]), .top_in(top_seq2 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [125:117]), .bottom_out(top_seq3 [ 63: 56]), .acc(arr_out[2][8] ));
PE pe_2_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq9 [125:117]), .top_in(top_seq2 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[125:117]), .bottom_out(top_seq3 [ 55: 48]), .acc(arr_out[2][9] ));
PE pe_2_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq10[125:117]), .top_in(top_seq2 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[125:117]), .bottom_out(top_seq3 [ 47: 40]), .acc(arr_out[2][10]));
PE pe_2_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq11[125:117]), .top_in(top_seq2 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[125:117]), .bottom_out(top_seq3 [ 39: 32]), .acc(arr_out[2][11]));
PE pe_2_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq12[125:117]), .top_in(top_seq2 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[125:117]), .bottom_out(top_seq3 [ 31: 24]), .acc(arr_out[2][12]));
PE pe_2_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq13[125:117]), .top_in(top_seq2 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[125:117]), .bottom_out(top_seq3 [ 23: 16]), .acc(arr_out[2][13]));
PE pe_2_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq14[125:117]), .top_in(top_seq2 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[125:117]), .bottom_out(top_seq3 [ 15:  8]), .acc(arr_out[2][14]));
PE pe_2_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq15[125:117]), .top_in(top_seq2 [  7:  0]), .pe_rst_seq(sys_rst_seq18), .right_out(     right[125:117]), .bottom_out(top_seq3 [  7:  0]), .acc(arr_out[2][15]));

PE pe_3_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq3),  .left_in(left_seq0 [116:108]), .top_in(top_seq3 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [116:108]), .bottom_out(top_seq4 [127:120]), .acc(arr_out[3][0] ));
PE pe_3_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq4),  .left_in(left_seq1 [116:108]), .top_in(top_seq3 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [116:108]), .bottom_out(top_seq4 [119:112]), .acc(arr_out[3][1] ));
PE pe_3_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq5),  .left_in(left_seq2 [116:108]), .top_in(top_seq3 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [116:108]), .bottom_out(top_seq4 [111:104]), .acc(arr_out[3][2] ));
PE pe_3_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq6),  .left_in(left_seq3 [116:108]), .top_in(top_seq3 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [116:108]), .bottom_out(top_seq4 [103: 96]), .acc(arr_out[3][3] ));
PE pe_3_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7),  .left_in(left_seq4 [116:108]), .top_in(top_seq3 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [116:108]), .bottom_out(top_seq4 [ 95: 88]), .acc(arr_out[3][4] ));
PE pe_3_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8),  .left_in(left_seq5 [116:108]), .top_in(top_seq3 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [116:108]), .bottom_out(top_seq4 [ 87: 80]), .acc(arr_out[3][5] ));
PE pe_3_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq6 [116:108]), .top_in(top_seq3 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [116:108]), .bottom_out(top_seq4 [ 79: 72]), .acc(arr_out[3][6] ));
PE pe_3_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq7 [116:108]), .top_in(top_seq3 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [116:108]), .bottom_out(top_seq4 [ 71: 64]), .acc(arr_out[3][7] ));
PE pe_3_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq8 [116:108]), .top_in(top_seq3 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [116:108]), .bottom_out(top_seq4 [ 63: 56]), .acc(arr_out[3][8] ));
PE pe_3_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq9 [116:108]), .top_in(top_seq3 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[116:108]), .bottom_out(top_seq4 [ 55: 48]), .acc(arr_out[3][9] ));
PE pe_3_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq10[116:108]), .top_in(top_seq3 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[116:108]), .bottom_out(top_seq4 [ 47: 40]), .acc(arr_out[3][10]));
PE pe_3_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq11[116:108]), .top_in(top_seq3 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[116:108]), .bottom_out(top_seq4 [ 39: 32]), .acc(arr_out[3][11]));
PE pe_3_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq12[116:108]), .top_in(top_seq3 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[116:108]), .bottom_out(top_seq4 [ 31: 24]), .acc(arr_out[3][12]));
PE pe_3_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq13[116:108]), .top_in(top_seq3 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[116:108]), .bottom_out(top_seq4 [ 23: 16]), .acc(arr_out[3][13]));
PE pe_3_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq14[116:108]), .top_in(top_seq3 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[116:108]), .bottom_out(top_seq4 [ 15:  8]), .acc(arr_out[3][14]));
PE pe_3_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq15[116:108]), .top_in(top_seq3 [  7:  0]), .pe_rst_seq(sys_rst_seq19), .right_out(     right[116:108]), .bottom_out(top_seq4 [  7:  0]), .acc(arr_out[3][15]));

PE pe_4_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq4),  .left_in(left_seq0 [107: 99]), .top_in(top_seq4 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [107: 99]), .bottom_out(top_seq5 [127:120]), .acc(arr_out[4][0] ));
PE pe_4_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq5),  .left_in(left_seq1 [107: 99]), .top_in(top_seq4 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [107: 99]), .bottom_out(top_seq5 [119:112]), .acc(arr_out[4][1] ));
PE pe_4_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq6),  .left_in(left_seq2 [107: 99]), .top_in(top_seq4 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [107: 99]), .bottom_out(top_seq5 [111:104]), .acc(arr_out[4][2] ));
PE pe_4_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7),  .left_in(left_seq3 [107: 99]), .top_in(top_seq4 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [107: 99]), .bottom_out(top_seq5 [103: 96]), .acc(arr_out[4][3] ));
PE pe_4_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8),  .left_in(left_seq4 [107: 99]), .top_in(top_seq4 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [107: 99]), .bottom_out(top_seq5 [ 95: 88]), .acc(arr_out[4][4] ));
PE pe_4_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq5 [107: 99]), .top_in(top_seq4 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [107: 99]), .bottom_out(top_seq5 [ 87: 80]), .acc(arr_out[4][5] ));
PE pe_4_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq6 [107: 99]), .top_in(top_seq4 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [107: 99]), .bottom_out(top_seq5 [ 79: 72]), .acc(arr_out[4][6] ));
PE pe_4_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq7 [107: 99]), .top_in(top_seq4 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [107: 99]), .bottom_out(top_seq5 [ 71: 64]), .acc(arr_out[4][7] ));
PE pe_4_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq8 [107: 99]), .top_in(top_seq4 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [107: 99]), .bottom_out(top_seq5 [ 63: 56]), .acc(arr_out[4][8] ));
PE pe_4_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq9 [107: 99]), .top_in(top_seq4 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[107: 99]), .bottom_out(top_seq5 [ 55: 48]), .acc(arr_out[4][9] ));
PE pe_4_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq10[107: 99]), .top_in(top_seq4 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[107: 99]), .bottom_out(top_seq5 [ 47: 40]), .acc(arr_out[4][10]));
PE pe_4_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq11[107: 99]), .top_in(top_seq4 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[107: 99]), .bottom_out(top_seq5 [ 39: 32]), .acc(arr_out[4][11]));
PE pe_4_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq12[107: 99]), .top_in(top_seq4 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[107: 99]), .bottom_out(top_seq5 [ 31: 24]), .acc(arr_out[4][12]));
PE pe_4_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq13[107: 99]), .top_in(top_seq4 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[107: 99]), .bottom_out(top_seq5 [ 23: 16]), .acc(arr_out[4][13]));
PE pe_4_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq14[107: 99]), .top_in(top_seq4 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[107: 99]), .bottom_out(top_seq5 [ 15:  8]), .acc(arr_out[4][14]));
PE pe_4_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq15[107: 99]), .top_in(top_seq4 [  7:  0]), .pe_rst_seq(sys_rst_seq20), .right_out(     right[107: 99]), .bottom_out(top_seq5 [  7:  0]), .acc(arr_out[4][15]));

PE pe_5_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq5),  .left_in(left_seq0 [ 98: 90]), .top_in(top_seq5 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 98: 90]), .bottom_out(top_seq6 [127:120]), .acc(arr_out[5][0] ));
PE pe_5_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq6),  .left_in(left_seq1 [ 98: 90]), .top_in(top_seq5 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 98: 90]), .bottom_out(top_seq6 [119:112]), .acc(arr_out[5][1] ));
PE pe_5_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7),  .left_in(left_seq2 [ 98: 90]), .top_in(top_seq5 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 98: 90]), .bottom_out(top_seq6 [111:104]), .acc(arr_out[5][2] ));
PE pe_5_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8),  .left_in(left_seq3 [ 98: 90]), .top_in(top_seq5 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 98: 90]), .bottom_out(top_seq6 [103: 96]), .acc(arr_out[5][3] ));
PE pe_5_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq4 [ 98: 90]), .top_in(top_seq5 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 98: 90]), .bottom_out(top_seq6 [ 95: 88]), .acc(arr_out[5][4] ));
PE pe_5_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq5 [ 98: 90]), .top_in(top_seq5 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 98: 90]), .bottom_out(top_seq6 [ 87: 80]), .acc(arr_out[5][5] ));
PE pe_5_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq6 [ 98: 90]), .top_in(top_seq5 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 98: 90]), .bottom_out(top_seq6 [ 79: 72]), .acc(arr_out[5][6] ));
PE pe_5_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq7 [ 98: 90]), .top_in(top_seq5 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 98: 90]), .bottom_out(top_seq6 [ 71: 64]), .acc(arr_out[5][7] ));
PE pe_5_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq8 [ 98: 90]), .top_in(top_seq5 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 98: 90]), .bottom_out(top_seq6 [ 63: 56]), .acc(arr_out[5][8] ));
PE pe_5_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq9 [ 98: 90]), .top_in(top_seq5 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 98: 90]), .bottom_out(top_seq6 [ 55: 48]), .acc(arr_out[5][9] ));
PE pe_5_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq10[ 98: 90]), .top_in(top_seq5 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 98: 90]), .bottom_out(top_seq6 [ 47: 40]), .acc(arr_out[5][10]));
PE pe_5_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq11[ 98: 90]), .top_in(top_seq5 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 98: 90]), .bottom_out(top_seq6 [ 39: 32]), .acc(arr_out[5][11]));
PE pe_5_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq12[ 98: 90]), .top_in(top_seq5 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 98: 90]), .bottom_out(top_seq6 [ 31: 24]), .acc(arr_out[5][12]));
PE pe_5_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq13[ 98: 90]), .top_in(top_seq5 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 98: 90]), .bottom_out(top_seq6 [ 23: 16]), .acc(arr_out[5][13]));
PE pe_5_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq14[ 98: 90]), .top_in(top_seq5 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 98: 90]), .bottom_out(top_seq6 [ 15:  8]), .acc(arr_out[5][14]));
PE pe_5_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq15[ 98: 90]), .top_in(top_seq5 [  7:  0]), .pe_rst_seq(sys_rst_seq21), .right_out(     right[ 98: 90]), .bottom_out(top_seq6 [  7:  0]), .acc(arr_out[5][15]));

PE pe_6_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq6),  .left_in(left_seq0 [ 89: 81]), .top_in(top_seq6 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 89: 81]), .bottom_out(top_seq7 [127:120]), .acc(arr_out[6][0] ));
PE pe_6_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7),  .left_in(left_seq1 [ 89: 81]), .top_in(top_seq6 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 89: 81]), .bottom_out(top_seq7 [119:112]), .acc(arr_out[6][1] ));
PE pe_6_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8),  .left_in(left_seq2 [ 89: 81]), .top_in(top_seq6 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 89: 81]), .bottom_out(top_seq7 [111:104]), .acc(arr_out[6][2] ));
PE pe_6_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq3 [ 89: 81]), .top_in(top_seq6 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 89: 81]), .bottom_out(top_seq7 [103: 96]), .acc(arr_out[6][3] ));
PE pe_6_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq4 [ 89: 81]), .top_in(top_seq6 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 89: 81]), .bottom_out(top_seq7 [ 95: 88]), .acc(arr_out[6][4] ));
PE pe_6_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq5 [ 89: 81]), .top_in(top_seq6 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 89: 81]), .bottom_out(top_seq7 [ 87: 80]), .acc(arr_out[6][5] ));
PE pe_6_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq6 [ 89: 81]), .top_in(top_seq6 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 89: 81]), .bottom_out(top_seq7 [ 79: 72]), .acc(arr_out[6][6] ));
PE pe_6_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq7 [ 89: 81]), .top_in(top_seq6 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 89: 81]), .bottom_out(top_seq7 [ 71: 64]), .acc(arr_out[6][7] ));
PE pe_6_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq8 [ 89: 81]), .top_in(top_seq6 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 89: 81]), .bottom_out(top_seq7 [ 63: 56]), .acc(arr_out[6][8] ));
PE pe_6_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq9 [ 89: 81]), .top_in(top_seq6 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 89: 81]), .bottom_out(top_seq7 [ 55: 48]), .acc(arr_out[6][9] ));
PE pe_6_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq10[ 89: 81]), .top_in(top_seq6 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 89: 81]), .bottom_out(top_seq7 [ 47: 40]), .acc(arr_out[6][10]));
PE pe_6_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq11[ 89: 81]), .top_in(top_seq6 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 89: 81]), .bottom_out(top_seq7 [ 39: 32]), .acc(arr_out[6][11]));
PE pe_6_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq12[ 89: 81]), .top_in(top_seq6 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 89: 81]), .bottom_out(top_seq7 [ 31: 24]), .acc(arr_out[6][12]));
PE pe_6_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq13[ 89: 81]), .top_in(top_seq6 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 89: 81]), .bottom_out(top_seq7 [ 23: 16]), .acc(arr_out[6][13]));
PE pe_6_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq14[ 89: 81]), .top_in(top_seq6 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 89: 81]), .bottom_out(top_seq7 [ 15:  8]), .acc(arr_out[6][14]));
PE pe_6_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq15[ 89: 81]), .top_in(top_seq6 [  7:  0]), .pe_rst_seq(sys_rst_seq22), .right_out(     right[ 89: 81]), .bottom_out(top_seq7 [  7:  0]), .acc(arr_out[6][15]));

PE pe_7_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq7),  .left_in(left_seq0 [ 80: 72]), .top_in(top_seq7 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 80: 72]), .bottom_out(top_seq8 [127:120]), .acc(arr_out[7][0] ));
PE pe_7_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8),  .left_in(left_seq1 [ 80: 72]), .top_in(top_seq7 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 80: 72]), .bottom_out(top_seq8 [119:112]), .acc(arr_out[7][1] ));
PE pe_7_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq2 [ 80: 72]), .top_in(top_seq7 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 80: 72]), .bottom_out(top_seq8 [111:104]), .acc(arr_out[7][2] ));
PE pe_7_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq3 [ 80: 72]), .top_in(top_seq7 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 80: 72]), .bottom_out(top_seq8 [103: 96]), .acc(arr_out[7][3] ));
PE pe_7_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq4 [ 80: 72]), .top_in(top_seq7 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 80: 72]), .bottom_out(top_seq8 [ 95: 88]), .acc(arr_out[7][4] ));
PE pe_7_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq5 [ 80: 72]), .top_in(top_seq7 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 80: 72]), .bottom_out(top_seq8 [ 87: 80]), .acc(arr_out[7][5] ));
PE pe_7_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq6 [ 80: 72]), .top_in(top_seq7 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 80: 72]), .bottom_out(top_seq8 [ 79: 72]), .acc(arr_out[7][6] ));
PE pe_7_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq7 [ 80: 72]), .top_in(top_seq7 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 80: 72]), .bottom_out(top_seq8 [ 71: 64]), .acc(arr_out[7][7] ));
PE pe_7_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq8 [ 80: 72]), .top_in(top_seq7 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 80: 72]), .bottom_out(top_seq8 [ 63: 56]), .acc(arr_out[7][8] ));
PE pe_7_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq9 [ 80: 72]), .top_in(top_seq7 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 80: 72]), .bottom_out(top_seq8 [ 55: 48]), .acc(arr_out[7][9] ));
PE pe_7_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq10[ 80: 72]), .top_in(top_seq7 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 80: 72]), .bottom_out(top_seq8 [ 47: 40]), .acc(arr_out[7][10]));
PE pe_7_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq11[ 80: 72]), .top_in(top_seq7 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 80: 72]), .bottom_out(top_seq8 [ 39: 32]), .acc(arr_out[7][11]));
PE pe_7_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq12[ 80: 72]), .top_in(top_seq7 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 80: 72]), .bottom_out(top_seq8 [ 31: 24]), .acc(arr_out[7][12]));
PE pe_7_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq13[ 80: 72]), .top_in(top_seq7 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 80: 72]), .bottom_out(top_seq8 [ 23: 16]), .acc(arr_out[7][13]));
PE pe_7_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq14[ 80: 72]), .top_in(top_seq7 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 80: 72]), .bottom_out(top_seq8 [ 15:  8]), .acc(arr_out[7][14]));
PE pe_7_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq15[ 80: 72]), .top_in(top_seq7 [  7:  0]), .pe_rst_seq(sys_rst_seq23), .right_out(     right[ 80: 72]), .bottom_out(top_seq8 [  7:  0]), .acc(arr_out[7][15]));

PE pe_8_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq8),  .left_in(left_seq0 [ 71: 63]), .top_in(top_seq8 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 71: 63]), .bottom_out(top_seq9 [127:120]), .acc(arr_out[8][0] ));
PE pe_8_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq1 [ 71: 63]), .top_in(top_seq8 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 71: 63]), .bottom_out(top_seq9 [119:112]), .acc(arr_out[8][1] ));
PE pe_8_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq2 [ 71: 63]), .top_in(top_seq8 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 71: 63]), .bottom_out(top_seq9 [111:104]), .acc(arr_out[8][2] ));
PE pe_8_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq3 [ 71: 63]), .top_in(top_seq8 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 71: 63]), .bottom_out(top_seq9 [103: 96]), .acc(arr_out[8][3] ));
PE pe_8_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq4 [ 71: 63]), .top_in(top_seq8 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 71: 63]), .bottom_out(top_seq9 [ 95: 88]), .acc(arr_out[8][4] ));
PE pe_8_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq5 [ 71: 63]), .top_in(top_seq8 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 71: 63]), .bottom_out(top_seq9 [ 87: 80]), .acc(arr_out[8][5] ));
PE pe_8_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq6 [ 71: 63]), .top_in(top_seq8 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 71: 63]), .bottom_out(top_seq9 [ 79: 72]), .acc(arr_out[8][6] ));
PE pe_8_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq7 [ 71: 63]), .top_in(top_seq8 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 71: 63]), .bottom_out(top_seq9 [ 71: 64]), .acc(arr_out[8][7] ));
PE pe_8_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq8 [ 71: 63]), .top_in(top_seq8 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 71: 63]), .bottom_out(top_seq9 [ 63: 56]), .acc(arr_out[8][8] ));
PE pe_8_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq9 [ 71: 63]), .top_in(top_seq8 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 71: 63]), .bottom_out(top_seq9 [ 55: 48]), .acc(arr_out[8][9] ));
PE pe_8_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq10[ 71: 63]), .top_in(top_seq8 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 71: 63]), .bottom_out(top_seq9 [ 47: 40]), .acc(arr_out[8][10]));
PE pe_8_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq11[ 71: 63]), .top_in(top_seq8 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 71: 63]), .bottom_out(top_seq9 [ 39: 32]), .acc(arr_out[8][11]));
PE pe_8_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq12[ 71: 63]), .top_in(top_seq8 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 71: 63]), .bottom_out(top_seq9 [ 31: 24]), .acc(arr_out[8][12]));
PE pe_8_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq13[ 71: 63]), .top_in(top_seq8 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 71: 63]), .bottom_out(top_seq9 [ 23: 16]), .acc(arr_out[8][13]));
PE pe_8_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq14[ 71: 63]), .top_in(top_seq8 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 71: 63]), .bottom_out(top_seq9 [ 15:  8]), .acc(arr_out[8][14]));
PE pe_8_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq15[ 71: 63]), .top_in(top_seq8 [  7:  0]), .pe_rst_seq(sys_rst_seq24), .right_out(     right[ 71: 63]), .bottom_out(top_seq9 [  7:  0]), .acc(arr_out[8][15]));

PE pe_9_0  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq9),  .left_in(left_seq0 [ 62: 54]), .top_in(top_seq9 [127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 62: 54]), .bottom_out(top_seq10[127:120]), .acc(arr_out[9][0] ));
PE pe_9_1  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq1 [ 62: 54]), .top_in(top_seq9 [119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 62: 54]), .bottom_out(top_seq10[119:112]), .acc(arr_out[9][1] ));
PE pe_9_2  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq2 [ 62: 54]), .top_in(top_seq9 [111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 62: 54]), .bottom_out(top_seq10[111:104]), .acc(arr_out[9][2] ));
PE pe_9_3  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq3 [ 62: 54]), .top_in(top_seq9 [103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 62: 54]), .bottom_out(top_seq10[103: 96]), .acc(arr_out[9][3] ));
PE pe_9_4  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq4 [ 62: 54]), .top_in(top_seq9 [ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 62: 54]), .bottom_out(top_seq10[ 95: 88]), .acc(arr_out[9][4] ));
PE pe_9_5  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq5 [ 62: 54]), .top_in(top_seq9 [ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 62: 54]), .bottom_out(top_seq10[ 87: 80]), .acc(arr_out[9][5] ));
PE pe_9_6  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq6 [ 62: 54]), .top_in(top_seq9 [ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 62: 54]), .bottom_out(top_seq10[ 79: 72]), .acc(arr_out[9][6] ));
PE pe_9_7  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq7 [ 62: 54]), .top_in(top_seq9 [ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 62: 54]), .bottom_out(top_seq10[ 71: 64]), .acc(arr_out[9][7] ));
PE pe_9_8  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq8 [ 62: 54]), .top_in(top_seq9 [ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 62: 54]), .bottom_out(top_seq10[ 63: 56]), .acc(arr_out[9][8] ));
PE pe_9_9  (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq9 [ 62: 54]), .top_in(top_seq9 [ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 62: 54]), .bottom_out(top_seq10[ 55: 48]), .acc(arr_out[9][9] ));
PE pe_9_10 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq10[ 62: 54]), .top_in(top_seq9 [ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 62: 54]), .bottom_out(top_seq10[ 47: 40]), .acc(arr_out[9][10]));
PE pe_9_11 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq11[ 62: 54]), .top_in(top_seq9 [ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 62: 54]), .bottom_out(top_seq10[ 39: 32]), .acc(arr_out[9][11]));
PE pe_9_12 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq12[ 62: 54]), .top_in(top_seq9 [ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 62: 54]), .bottom_out(top_seq10[ 31: 24]), .acc(arr_out[9][12]));
PE pe_9_13 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq13[ 62: 54]), .top_in(top_seq9 [ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 62: 54]), .bottom_out(top_seq10[ 23: 16]), .acc(arr_out[9][13]));
PE pe_9_14 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq14[ 62: 54]), .top_in(top_seq9 [ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 62: 54]), .bottom_out(top_seq10[ 15:  8]), .acc(arr_out[9][14]));
PE pe_9_15 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq24), .left_in(left_seq15[ 62: 54]), .top_in(top_seq9 [  7:  0]), .pe_rst_seq(sys_rst_seq25), .right_out(     right[ 62: 54]), .bottom_out(top_seq10[  7:  0]), .acc(arr_out[9][15]));

PE pe_10_0 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq0 [ 53: 45]), .top_in(top_seq10[127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 53: 45]), .bottom_out(top_seq11[127:120]), .acc(arr_out[10][0] ));
PE pe_10_1 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq1 [ 53: 45]), .top_in(top_seq10[119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 53: 45]), .bottom_out(top_seq11[119:112]), .acc(arr_out[10][1] ));
PE pe_10_2 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq2 [ 53: 45]), .top_in(top_seq10[111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 53: 45]), .bottom_out(top_seq11[111:104]), .acc(arr_out[10][2] ));
PE pe_10_3 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq3 [ 53: 45]), .top_in(top_seq10[103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 53: 45]), .bottom_out(top_seq11[103: 96]), .acc(arr_out[10][3] ));
PE pe_10_4 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq4 [ 53: 45]), .top_in(top_seq10[ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 53: 45]), .bottom_out(top_seq11[ 95: 88]), .acc(arr_out[10][4] ));
PE pe_10_5 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq5 [ 53: 45]), .top_in(top_seq10[ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 53: 45]), .bottom_out(top_seq11[ 87: 80]), .acc(arr_out[10][5] ));
PE pe_10_6 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq6 [ 53: 45]), .top_in(top_seq10[ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 53: 45]), .bottom_out(top_seq11[ 79: 72]), .acc(arr_out[10][6] ));
PE pe_10_7 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq7 [ 53: 45]), .top_in(top_seq10[ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 53: 45]), .bottom_out(top_seq11[ 71: 64]), .acc(arr_out[10][7] ));
PE pe_10_8 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq8 [ 53: 45]), .top_in(top_seq10[ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 53: 45]), .bottom_out(top_seq11[ 63: 56]), .acc(arr_out[10][8] ));
PE pe_10_9 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq9 [ 53: 45]), .top_in(top_seq10[ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 53: 45]), .bottom_out(top_seq11[ 55: 48]), .acc(arr_out[10][9] ));
PE pe_10_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq10[ 53: 45]), .top_in(top_seq10[ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 53: 45]), .bottom_out(top_seq11[ 47: 40]), .acc(arr_out[10][10]));
PE pe_10_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq11[ 53: 45]), .top_in(top_seq10[ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 53: 45]), .bottom_out(top_seq11[ 39: 32]), .acc(arr_out[10][11]));
PE pe_10_12(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq12[ 53: 45]), .top_in(top_seq10[ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 53: 45]), .bottom_out(top_seq11[ 31: 24]), .acc(arr_out[10][12]));
PE pe_10_13(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq13[ 53: 45]), .top_in(top_seq10[ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 53: 45]), .bottom_out(top_seq11[ 23: 16]), .acc(arr_out[10][13]));
PE pe_10_14(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq24), .left_in(left_seq14[ 53: 45]), .top_in(top_seq10[ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 53: 45]), .bottom_out(top_seq11[ 15:  8]), .acc(arr_out[10][14]));
PE pe_10_15(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq25), .left_in(left_seq15[ 53: 45]), .top_in(top_seq10[  7:  0]), .pe_rst_seq(sys_rst_seq26), .right_out(     right[ 53: 45]), .bottom_out(top_seq11[  7:  0]), .acc(arr_out[10][15]));

PE pe_11_0 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq0 [ 44: 36]), .top_in(top_seq11[127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 44: 36]), .bottom_out(top_seq12[127:120]), .acc(arr_out[11][0] ));
PE pe_11_1 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq1 [ 44: 36]), .top_in(top_seq11[119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 44: 36]), .bottom_out(top_seq12[119:112]), .acc(arr_out[11][1] ));
PE pe_11_2 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq2 [ 44: 36]), .top_in(top_seq11[111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 44: 36]), .bottom_out(top_seq12[111:104]), .acc(arr_out[11][2] ));
PE pe_11_3 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq3 [ 44: 36]), .top_in(top_seq11[103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 44: 36]), .bottom_out(top_seq12[103: 96]), .acc(arr_out[11][3] ));
PE pe_11_4 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq4 [ 44: 36]), .top_in(top_seq11[ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 44: 36]), .bottom_out(top_seq12[ 95: 88]), .acc(arr_out[11][4] ));
PE pe_11_5 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq5 [ 44: 36]), .top_in(top_seq11[ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 44: 36]), .bottom_out(top_seq12[ 87: 80]), .acc(arr_out[11][5] ));
PE pe_11_6 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq6 [ 44: 36]), .top_in(top_seq11[ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 44: 36]), .bottom_out(top_seq12[ 79: 72]), .acc(arr_out[11][6] ));
PE pe_11_7 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq7 [ 44: 36]), .top_in(top_seq11[ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 44: 36]), .bottom_out(top_seq12[ 71: 64]), .acc(arr_out[11][7] ));
PE pe_11_8 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq8 [ 44: 36]), .top_in(top_seq11[ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 44: 36]), .bottom_out(top_seq12[ 63: 56]), .acc(arr_out[11][8] ));
PE pe_11_9 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq9 [ 44: 36]), .top_in(top_seq11[ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 44: 36]), .bottom_out(top_seq12[ 55: 48]), .acc(arr_out[11][9] ));
PE pe_11_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq10[ 44: 36]), .top_in(top_seq11[ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 44: 36]), .bottom_out(top_seq12[ 47: 40]), .acc(arr_out[11][10]));
PE pe_11_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq11[ 44: 36]), .top_in(top_seq11[ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 44: 36]), .bottom_out(top_seq12[ 39: 32]), .acc(arr_out[11][11]));
PE pe_11_12(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq12[ 44: 36]), .top_in(top_seq11[ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 44: 36]), .bottom_out(top_seq12[ 31: 24]), .acc(arr_out[11][12]));
PE pe_11_13(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq24), .left_in(left_seq13[ 44: 36]), .top_in(top_seq11[ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 44: 36]), .bottom_out(top_seq12[ 23: 16]), .acc(arr_out[11][13]));
PE pe_11_14(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq25), .left_in(left_seq14[ 44: 36]), .top_in(top_seq11[ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 44: 36]), .bottom_out(top_seq12[ 15:  8]), .acc(arr_out[11][14]));
PE pe_11_15(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq26), .left_in(left_seq15[ 44: 36]), .top_in(top_seq11[  7:  0]), .pe_rst_seq(sys_rst_seq27), .right_out(     right[ 44: 36]), .bottom_out(top_seq12[  7:  0]), .acc(arr_out[11][15]));

PE pe_12_0 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq0 [ 35: 27]), .top_in(top_seq12[127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 35: 27]), .bottom_out(top_seq13[127:120]), .acc(arr_out[12][0] ));
PE pe_12_1 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq1 [ 35: 27]), .top_in(top_seq12[119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 35: 27]), .bottom_out(top_seq13[119:112]), .acc(arr_out[12][1] ));
PE pe_12_2 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq2 [ 35: 27]), .top_in(top_seq12[111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 35: 27]), .bottom_out(top_seq13[111:104]), .acc(arr_out[12][2] ));
PE pe_12_3 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq3 [ 35: 27]), .top_in(top_seq12[103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 35: 27]), .bottom_out(top_seq13[103: 96]), .acc(arr_out[12][3] ));
PE pe_12_4 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq4 [ 35: 27]), .top_in(top_seq12[ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 35: 27]), .bottom_out(top_seq13[ 95: 88]), .acc(arr_out[12][4] ));
PE pe_12_5 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq5 [ 35: 27]), .top_in(top_seq12[ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 35: 27]), .bottom_out(top_seq13[ 87: 80]), .acc(arr_out[12][5] ));
PE pe_12_6 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq6 [ 35: 27]), .top_in(top_seq12[ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 35: 27]), .bottom_out(top_seq13[ 79: 72]), .acc(arr_out[12][6] ));
PE pe_12_7 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq7 [ 35: 27]), .top_in(top_seq12[ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 35: 27]), .bottom_out(top_seq13[ 71: 64]), .acc(arr_out[12][7] ));
PE pe_12_8 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq8 [ 35: 27]), .top_in(top_seq12[ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 35: 27]), .bottom_out(top_seq13[ 63: 56]), .acc(arr_out[12][8] ));
PE pe_12_9 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq9 [ 35: 27]), .top_in(top_seq12[ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 35: 27]), .bottom_out(top_seq13[ 55: 48]), .acc(arr_out[12][9] ));
PE pe_12_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq10[ 35: 27]), .top_in(top_seq12[ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 35: 27]), .bottom_out(top_seq13[ 47: 40]), .acc(arr_out[12][10]));
PE pe_12_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq11[ 35: 27]), .top_in(top_seq12[ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 35: 27]), .bottom_out(top_seq13[ 39: 32]), .acc(arr_out[12][11]));
PE pe_12_12(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq24), .left_in(left_seq12[ 35: 27]), .top_in(top_seq12[ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 35: 27]), .bottom_out(top_seq13[ 31: 24]), .acc(arr_out[12][12]));
PE pe_12_13(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq25), .left_in(left_seq13[ 35: 27]), .top_in(top_seq12[ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 35: 27]), .bottom_out(top_seq13[ 23: 16]), .acc(arr_out[12][13]));
PE pe_12_14(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq26), .left_in(left_seq14[ 35: 27]), .top_in(top_seq12[ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 35: 27]), .bottom_out(top_seq13[ 15:  8]), .acc(arr_out[12][14]));
PE pe_12_15(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq27), .left_in(left_seq15[ 35: 27]), .top_in(top_seq12[  7:  0]), .pe_rst_seq(sys_rst_seq28), .right_out(     right[ 35: 27]), .bottom_out(top_seq13[  7:  0]), .acc(arr_out[12][15]));

PE pe_13_0 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq0 [ 26: 18]), .top_in(top_seq13[127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 26: 18]), .bottom_out(top_seq14[127:120]), .acc(arr_out[13][0] ));
PE pe_13_1 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq1 [ 26: 18]), .top_in(top_seq13[119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 26: 18]), .bottom_out(top_seq14[119:112]), .acc(arr_out[13][1] ));
PE pe_13_2 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq2 [ 26: 18]), .top_in(top_seq13[111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 26: 18]), .bottom_out(top_seq14[111:104]), .acc(arr_out[13][2] ));
PE pe_13_3 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq3 [ 26: 18]), .top_in(top_seq13[103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 26: 18]), .bottom_out(top_seq14[103: 96]), .acc(arr_out[13][3] ));
PE pe_13_4 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq4 [ 26: 18]), .top_in(top_seq13[ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 26: 18]), .bottom_out(top_seq14[ 95: 88]), .acc(arr_out[13][4] ));
PE pe_13_5 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq5 [ 26: 18]), .top_in(top_seq13[ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 26: 18]), .bottom_out(top_seq14[ 87: 80]), .acc(arr_out[13][5] ));
PE pe_13_6 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq6 [ 26: 18]), .top_in(top_seq13[ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 26: 18]), .bottom_out(top_seq14[ 79: 72]), .acc(arr_out[13][6] ));
PE pe_13_7 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq7 [ 26: 18]), .top_in(top_seq13[ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 26: 18]), .bottom_out(top_seq14[ 71: 64]), .acc(arr_out[13][7] ));
PE pe_13_8 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq8 [ 26: 18]), .top_in(top_seq13[ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 26: 18]), .bottom_out(top_seq14[ 63: 56]), .acc(arr_out[13][8] ));
PE pe_13_9 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq9 [ 26: 18]), .top_in(top_seq13[ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 26: 18]), .bottom_out(top_seq14[ 55: 48]), .acc(arr_out[13][9] ));
PE pe_13_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq10[ 26: 18]), .top_in(top_seq13[ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 26: 18]), .bottom_out(top_seq14[ 47: 40]), .acc(arr_out[13][10]));
PE pe_13_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq24), .left_in(left_seq11[ 26: 18]), .top_in(top_seq13[ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 26: 18]), .bottom_out(top_seq14[ 39: 32]), .acc(arr_out[13][11]));
PE pe_13_12(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq25), .left_in(left_seq12[ 26: 18]), .top_in(top_seq13[ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 26: 18]), .bottom_out(top_seq14[ 31: 24]), .acc(arr_out[13][12]));
PE pe_13_13(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq26), .left_in(left_seq13[ 26: 18]), .top_in(top_seq13[ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 26: 18]), .bottom_out(top_seq14[ 23: 16]), .acc(arr_out[13][13]));
PE pe_13_14(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq27), .left_in(left_seq14[ 26: 18]), .top_in(top_seq13[ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 26: 18]), .bottom_out(top_seq14[ 15:  8]), .acc(arr_out[13][14]));
PE pe_13_15(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq28), .left_in(left_seq15[ 26: 18]), .top_in(top_seq13[  7:  0]), .pe_rst_seq(sys_rst_seq29), .right_out(     right[ 26: 18]), .bottom_out(top_seq14[  7:  0]), .acc(arr_out[13][15]));

PE pe_14_0 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq0 [ 17:  9]), .top_in(top_seq14[127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [ 17:  9]), .bottom_out(top_seq15[127:120]), .acc(arr_out[14][0] ));
PE pe_14_1 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq1 [ 17:  9]), .top_in(top_seq14[119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [ 17:  9]), .bottom_out(top_seq15[119:112]), .acc(arr_out[14][1] ));
PE pe_14_2 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq2 [ 17:  9]), .top_in(top_seq14[111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [ 17:  9]), .bottom_out(top_seq15[111:104]), .acc(arr_out[14][2] ));
PE pe_14_3 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq3 [ 17:  9]), .top_in(top_seq14[103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [ 17:  9]), .bottom_out(top_seq15[103: 96]), .acc(arr_out[14][3] ));
PE pe_14_4 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq4 [ 17:  9]), .top_in(top_seq14[ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [ 17:  9]), .bottom_out(top_seq15[ 95: 88]), .acc(arr_out[14][4] ));
PE pe_14_5 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq5 [ 17:  9]), .top_in(top_seq14[ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [ 17:  9]), .bottom_out(top_seq15[ 87: 80]), .acc(arr_out[14][5] ));
PE pe_14_6 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq6 [ 17:  9]), .top_in(top_seq14[ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [ 17:  9]), .bottom_out(top_seq15[ 79: 72]), .acc(arr_out[14][6] ));
PE pe_14_7 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq7 [ 17:  9]), .top_in(top_seq14[ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [ 17:  9]), .bottom_out(top_seq15[ 71: 64]), .acc(arr_out[14][7] ));
PE pe_14_8 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq8 [ 17:  9]), .top_in(top_seq14[ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [ 17:  9]), .bottom_out(top_seq15[ 63: 56]), .acc(arr_out[14][8] ));
PE pe_14_9 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq9 [ 17:  9]), .top_in(top_seq14[ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[ 17:  9]), .bottom_out(top_seq15[ 55: 48]), .acc(arr_out[14][9] ));
PE pe_14_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq24), .left_in(left_seq10[ 17:  9]), .top_in(top_seq14[ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[ 17:  9]), .bottom_out(top_seq15[ 47: 40]), .acc(arr_out[14][10]));
PE pe_14_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq25), .left_in(left_seq11[ 17:  9]), .top_in(top_seq14[ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[ 17:  9]), .bottom_out(top_seq15[ 39: 32]), .acc(arr_out[14][11]));
PE pe_14_12(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq26), .left_in(left_seq12[ 17:  9]), .top_in(top_seq14[ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[ 17:  9]), .bottom_out(top_seq15[ 31: 24]), .acc(arr_out[14][12]));
PE pe_14_13(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq27), .left_in(left_seq13[ 17:  9]), .top_in(top_seq14[ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[ 17:  9]), .bottom_out(top_seq15[ 23: 16]), .acc(arr_out[14][13]));
PE pe_14_14(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq28), .left_in(left_seq14[ 17:  9]), .top_in(top_seq14[ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[ 17:  9]), .bottom_out(top_seq15[ 15:  8]), .acc(arr_out[14][14]));
PE pe_14_15(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq29), .left_in(left_seq15[ 17:  9]), .top_in(top_seq14[  7:  0]), .pe_rst_seq(sys_rst_seq30), .right_out(     right[ 17:  9]), .bottom_out(top_seq15[  7:  0]), .acc(arr_out[14][15]));

PE pe_15_0 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq0 [  8:  0]), .top_in(top_seq15[127:120]), .pe_rst_seq(             ), .right_out(left_seq1 [  8:  0]), .bottom_out(   bottom[127:120]), .acc(arr_out[15][0] ));
PE pe_15_1 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq1 [  8:  0]), .top_in(top_seq15[119:112]), .pe_rst_seq(             ), .right_out(left_seq2 [  8:  0]), .bottom_out(   bottom[119:112]), .acc(arr_out[15][1] ));
PE pe_15_2 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq2 [  8:  0]), .top_in(top_seq15[111:104]), .pe_rst_seq(             ), .right_out(left_seq3 [  8:  0]), .bottom_out(   bottom[111:104]), .acc(arr_out[15][2] ));
PE pe_15_3 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq3 [  8:  0]), .top_in(top_seq15[103: 96]), .pe_rst_seq(             ), .right_out(left_seq4 [  8:  0]), .bottom_out(   bottom[103: 96]), .acc(arr_out[15][3] ));
PE pe_15_4 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq4 [  8:  0]), .top_in(top_seq15[ 95: 88]), .pe_rst_seq(             ), .right_out(left_seq5 [  8:  0]), .bottom_out(   bottom[ 95: 88]), .acc(arr_out[15][4] ));
PE pe_15_5 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq5 [  8:  0]), .top_in(top_seq15[ 87: 80]), .pe_rst_seq(             ), .right_out(left_seq6 [  8:  0]), .bottom_out(   bottom[ 87: 80]), .acc(arr_out[15][5] ));
PE pe_15_6 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq6 [  8:  0]), .top_in(top_seq15[ 79: 72]), .pe_rst_seq(             ), .right_out(left_seq7 [  8:  0]), .bottom_out(   bottom[ 79: 72]), .acc(arr_out[15][6] ));
PE pe_15_7 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq7 [  8:  0]), .top_in(top_seq15[ 71: 64]), .pe_rst_seq(             ), .right_out(left_seq8 [  8:  0]), .bottom_out(   bottom[ 71: 64]), .acc(arr_out[15][7] ));
PE pe_15_8 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq23), .left_in(left_seq8 [  8:  0]), .top_in(top_seq15[ 63: 56]), .pe_rst_seq(             ), .right_out(left_seq9 [  8:  0]), .bottom_out(   bottom[ 63: 56]), .acc(arr_out[15][8] ));
PE pe_15_9 (.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq24), .left_in(left_seq9 [  8:  0]), .top_in(top_seq15[ 55: 48]), .pe_rst_seq(             ), .right_out(left_seq10[  8:  0]), .bottom_out(   bottom[ 55: 48]), .acc(arr_out[15][9] ));
PE pe_15_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq25), .left_in(left_seq10[  8:  0]), .top_in(top_seq15[ 47: 40]), .pe_rst_seq(             ), .right_out(left_seq11[  8:  0]), .bottom_out(   bottom[ 47: 40]), .acc(arr_out[15][10]));
PE pe_15_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq26), .left_in(left_seq11[  8:  0]), .top_in(top_seq15[ 39: 32]), .pe_rst_seq(             ), .right_out(left_seq12[  8:  0]), .bottom_out(   bottom[ 39: 32]), .acc(arr_out[15][11]));
PE pe_15_12(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq27), .left_in(left_seq12[  8:  0]), .top_in(top_seq15[ 31: 24]), .pe_rst_seq(             ), .right_out(left_seq13[  8:  0]), .bottom_out(   bottom[ 31: 24]), .acc(arr_out[15][12]));
PE pe_15_13(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq28), .left_in(left_seq13[  8:  0]), .top_in(top_seq15[ 23: 16]), .pe_rst_seq(             ), .right_out(left_seq14[  8:  0]), .bottom_out(   bottom[ 23: 16]), .acc(arr_out[15][13]));
PE pe_15_14(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq29), .left_in(left_seq14[  8:  0]), .top_in(top_seq15[ 15:  8]), .pe_rst_seq(             ), .right_out(left_seq15[  8:  0]), .bottom_out(   bottom[ 15:  8]), .acc(arr_out[15][14]));
PE pe_15_15(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq30), .left_in(left_seq15[  8:  0]), .top_in(top_seq15[  7:  0]), .pe_rst_seq(sys_rst_seq31), .right_out(     right[  8:  0]), .bottom_out(   bottom[  7:  0]), .acc(arr_out[15][15]));

assign row0_out  = {arr_out[0][0] , arr_out[0][1] , arr_out[0][2] , arr_out[0][3] , arr_out[0][4] , arr_out[0][5] , arr_out[0][6] , arr_out[0][7] , arr_out[0][8] , arr_out[0][9] , arr_out[0][10] , arr_out[0][11] , arr_out[0][12] , arr_out[0][13] , arr_out[0][14] , arr_out[0][15] };
assign row1_out  = {arr_out[1][0] , arr_out[1][1] , arr_out[1][2] , arr_out[1][3] , arr_out[1][4] , arr_out[1][5] , arr_out[1][6] , arr_out[1][7] , arr_out[1][8] , arr_out[1][9] , arr_out[1][10] , arr_out[1][11] , arr_out[1][12] , arr_out[1][13] , arr_out[1][14] , arr_out[1][15] };
assign row2_out  = {arr_out[2][0] , arr_out[2][1] , arr_out[2][2] , arr_out[2][3] , arr_out[2][4] , arr_out[2][5] , arr_out[2][6] , arr_out[2][7] , arr_out[2][8] , arr_out[2][9] , arr_out[2][10] , arr_out[2][11] , arr_out[2][12] , arr_out[2][13] , arr_out[2][14] , arr_out[2][15] };
assign row3_out  = {arr_out[3][0] , arr_out[3][1] , arr_out[3][2] , arr_out[3][3] , arr_out[3][4] , arr_out[3][5] , arr_out[3][6] , arr_out[3][7] , arr_out[3][8] , arr_out[3][9] , arr_out[3][10] , arr_out[3][11] , arr_out[3][12] , arr_out[3][13] , arr_out[3][14] , arr_out[3][15] };
assign row4_out  = {arr_out[4][0] , arr_out[4][1] , arr_out[4][2] , arr_out[4][3] , arr_out[4][4] , arr_out[4][5] , arr_out[4][6] , arr_out[4][7] , arr_out[4][8] , arr_out[4][9] , arr_out[4][10] , arr_out[4][11] , arr_out[4][12] , arr_out[4][13] , arr_out[4][14] , arr_out[4][15] };
assign row5_out  = {arr_out[5][0] , arr_out[5][1] , arr_out[5][2] , arr_out[5][3] , arr_out[5][4] , arr_out[5][5] , arr_out[5][6] , arr_out[5][7] , arr_out[5][8] , arr_out[5][9] , arr_out[5][10] , arr_out[5][11] , arr_out[5][12] , arr_out[5][13] , arr_out[5][14] , arr_out[5][15] };
assign row6_out  = {arr_out[6][0] , arr_out[6][1] , arr_out[6][2] , arr_out[6][3] , arr_out[6][4] , arr_out[6][5] , arr_out[6][6] , arr_out[6][7] , arr_out[6][8] , arr_out[6][9] , arr_out[6][10] , arr_out[6][11] , arr_out[6][12] , arr_out[6][13] , arr_out[6][14] , arr_out[6][15] };
assign row7_out  = {arr_out[7][0] , arr_out[7][1] , arr_out[7][2] , arr_out[7][3] , arr_out[7][4] , arr_out[7][5] , arr_out[7][6] , arr_out[7][7] , arr_out[7][8] , arr_out[7][9] , arr_out[7][10] , arr_out[7][11] , arr_out[7][12] , arr_out[7][13] , arr_out[7][14] , arr_out[7][15] };
assign row8_out  = {arr_out[8][0] , arr_out[8][1] , arr_out[8][2] , arr_out[8][3] , arr_out[8][4] , arr_out[8][5] , arr_out[8][6] , arr_out[8][7] , arr_out[8][8] , arr_out[8][9] , arr_out[8][10] , arr_out[8][11] , arr_out[8][12] , arr_out[8][13] , arr_out[8][14] , arr_out[8][15] };
assign row9_out  = {arr_out[9][0] , arr_out[9][1] , arr_out[9][2] , arr_out[9][3] , arr_out[9][4] , arr_out[9][5] , arr_out[9][6] , arr_out[9][7] , arr_out[9][8] , arr_out[9][9] , arr_out[9][10] , arr_out[9][11] , arr_out[9][12] , arr_out[9][13] , arr_out[9][14] , arr_out[9][15] };
assign row10_out = {arr_out[10][0], arr_out[10][1], arr_out[10][2], arr_out[10][3], arr_out[10][4], arr_out[10][5], arr_out[10][6], arr_out[10][7], arr_out[10][8], arr_out[10][9], arr_out[10][10], arr_out[10][11], arr_out[10][12], arr_out[10][13], arr_out[10][14], arr_out[10][15]};
assign row11_out = {arr_out[11][0], arr_out[11][1], arr_out[11][2], arr_out[11][3], arr_out[11][4], arr_out[11][5], arr_out[11][6], arr_out[11][7], arr_out[11][8], arr_out[11][9], arr_out[11][10], arr_out[11][11], arr_out[11][12], arr_out[11][13], arr_out[11][14], arr_out[11][15]};
assign row12_out = {arr_out[12][0], arr_out[12][1], arr_out[12][2], arr_out[12][3], arr_out[12][4], arr_out[12][5], arr_out[12][6], arr_out[12][7], arr_out[12][8], arr_out[12][9], arr_out[12][10], arr_out[12][11], arr_out[12][12], arr_out[12][13], arr_out[12][14], arr_out[12][15]};
assign row13_out = {arr_out[13][0], arr_out[13][1], arr_out[13][2], arr_out[13][3], arr_out[13][4], arr_out[13][5], arr_out[13][6], arr_out[13][7], arr_out[13][8], arr_out[13][9], arr_out[13][10], arr_out[13][11], arr_out[13][12], arr_out[13][13], arr_out[13][14], arr_out[13][15]};
assign row14_out = {arr_out[14][0], arr_out[14][1], arr_out[14][2], arr_out[14][3], arr_out[14][4], arr_out[14][5], arr_out[14][6], arr_out[14][7], arr_out[14][8], arr_out[14][9], arr_out[14][10], arr_out[14][11], arr_out[14][12], arr_out[14][13], arr_out[14][14], arr_out[14][15]};
assign row15_out = {arr_out[15][0], arr_out[15][1], arr_out[15][2], arr_out[15][3], arr_out[15][4], arr_out[15][5], arr_out[15][6], arr_out[15][7], arr_out[15][8], arr_out[15][9], arr_out[15][10], arr_out[15][11], arr_out[15][12], arr_out[15][13], arr_out[15][14], arr_out[15][15]};

always @(posedge clk) begin
    if (!rst_n) begin
        out_valid_pp0 <= 0;
        out_valid_pp1 <= 0;
        out_valid_pp2 <= 0;
        out_valid_pp3 <= 0;
        out_valid_pp4 <= 0;
        out_valid_pp5 <= 0;
        out_valid_pp6 <= 0;
        out_valid_pp7 <= 0;
        out_valid_pp8 <= 0;
        out_valid_pp9 <= 0;
        out_valid_pp10<= 0;
        out_valid_pp11<= 0;
        out_valid_pp12<= 0;
        out_valid_pp13<= 0;
        out_valid <= 0;
    end
    else begin
        out_valid_pp0 <= in_valid;
        out_valid_pp1 <= out_valid_pp0;
        out_valid_pp2 <= out_valid_pp1;
        out_valid_pp3 <= out_valid_pp2;
        out_valid_pp4 <= out_valid_pp3;
        out_valid_pp5 <= out_valid_pp4;
        out_valid_pp6 <= out_valid_pp5;
        out_valid_pp7 <= out_valid_pp6;
        out_valid_pp8 <= out_valid_pp7;
        out_valid_pp9 <= out_valid_pp8;
        out_valid_pp10<= out_valid_pp9;
        out_valid_pp11<= out_valid_pp10;
        out_valid_pp12<= out_valid_pp11;
        out_valid_pp13<= out_valid_pp12;
        out_valid <= out_valid_pp13;
    end
end

endmodule


module SYS_12x12_ARRAY (
    clk,
    rst_n,
    in_valid,
    offset_valid,
    sys_rst_seq0,
    left,
    top,
    out_valid,
    row0_out,
    row1_out,
    row2_out,
    row3_out,
    row4_out,
    row5_out,
    row6_out,
    row7_out,
    row8_out,
    row9_out,
    row10_out,
    row11_out
);

// IO
input clk, rst_n;
input [11:0] in_valid;
input offset_valid;
input sys_rst_seq0;
input [95:0] left, top;

output reg [11:0] out_valid;
output wire [383:0] row0_out, row1_out, row2_out, row3_out, row4_out, row5_out, row6_out, row7_out, row8_out, row9_out, row10_out, row11_out;

// Signals
wire sys_rst_seq1, sys_rst_seq2, sys_rst_seq3, sys_rst_seq4, sys_rst_seq5, sys_rst_seq6, sys_rst_seq7, sys_rst_seq8, sys_rst_seq9, sys_rst_seq10, sys_rst_seq11, sys_rst_seq12, sys_rst_seq13, sys_rst_seq14, sys_rst_seq15, sys_rst_seq16, sys_rst_seq17, sys_rst_seq18, sys_rst_seq19, sys_rst_seq20, sys_rst_seq21, sys_rst_seq22, sys_rst_seq23;
wire [107:0] left_seq0, left_seq1, left_seq2, left_seq3, left_seq4, left_seq5, left_seq6, left_seq7, left_seq8, left_seq9, left_seq10, left_seq11, right;
wire [95:0] top_seq1, top_seq2, top_seq3, top_seq4, top_seq5, top_seq6, top_seq7, top_seq8, top_seq9, top_seq10, top_seq11, bottom;

wire signed [8:0] left_offset0 = offset_valid ? $signed(left[95:88]) + 128 : $signed(left[95:88]);
wire signed [8:0] left_offset1 = offset_valid ? $signed(left[87:80]) + 128 : $signed(left[87:80]);
wire signed [8:0] left_offset2 = offset_valid ? $signed(left[79:72]) + 128 : $signed(left[79:72]);
wire signed [8:0] left_offset3 = offset_valid ? $signed(left[71:64]) + 128 : $signed(left[71:64]);
wire signed [8:0] left_offset4 = offset_valid ? $signed(left[63:56]) + 128 : $signed(left[63:56]);
wire signed [8:0] left_offset5 = offset_valid ? $signed(left[55:48]) + 128 : $signed(left[55:48]);
wire signed [8:0] left_offset6 = offset_valid ? $signed(left[47:40]) + 128 : $signed(left[47:40]);
wire signed [8:0] left_offset7 = offset_valid ? $signed(left[39:32]) + 128 : $signed(left[39:32]);
wire signed [8:0] left_offset8 = offset_valid ? $signed(left[31:24]) + 128 : $signed(left[31:24]);
wire signed [8:0] left_offset9 = offset_valid ? $signed(left[23:16]) + 128 : $signed(left[23:16]);
wire signed [8:0] left_offset10= offset_valid ? $signed(left[15: 8]) + 128 : $signed(left[15: 8]);
wire signed [8:0] left_offset11= offset_valid ? $signed(left[ 7: 0]) + 128 : $signed(left[ 7: 0]);
assign left_seq0 = {left_offset0[8:0], left_offset1[8:0], left_offset2[8:0], left_offset3[8:0], left_offset4[8:0], left_offset5[8:0], left_offset6[8:0], left_offset7[8:0], left_offset8[8:0], left_offset9[8:0], left_offset10[8:0], left_offset11[8:0]};

reg [11:0] out_valid_pp0, out_valid_pp1, out_valid_pp2, out_valid_pp3, out_valid_pp4, out_valid_pp5, out_valid_pp6, out_valid_pp7, out_valid_pp8, out_valid_pp9;

wire [31:0] arr_out [0:11][0:11];

// Design
// Signal naming is based on 0-indexing.
PE pe_0_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq0),  .left_in(left_seq0[107:99]), .top_in(     top[95:88]),  .pe_rst_seq(sys_rst_seq1),  .right_out(left_seq1[107:99]), .bottom_out(top_seq1[95:88]),  .acc(arr_out[0][0]));
PE pe_0_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq1),  .left_in(left_seq1[107:99]), .top_in(     top[87:80]),  .pe_rst_seq(sys_rst_seq2),  .right_out(left_seq2[107:99]), .bottom_out(top_seq1[87:80]),  .acc(arr_out[0][1]));
PE pe_0_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq2),  .left_in(left_seq2[107:99]), .top_in(     top[79:72]),  .pe_rst_seq(sys_rst_seq3),  .right_out(left_seq3[107:99]), .bottom_out(top_seq1[79:72]),  .acc(arr_out[0][2]));
PE pe_0_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3),  .left_in(left_seq3[107:99]), .top_in(     top[71:64]),  .pe_rst_seq(sys_rst_seq4),  .right_out(left_seq4[107:99]), .bottom_out(top_seq1[71:64]),  .acc(arr_out[0][3]));
PE pe_0_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4),  .left_in(left_seq4[107:99]), .top_in(     top[63:56]),  .pe_rst_seq(sys_rst_seq5),  .right_out(left_seq5[107:99]), .bottom_out(top_seq1[63:56]),  .acc(arr_out[0][4]));
PE pe_0_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5),  .left_in(left_seq5[107:99]), .top_in(     top[55:48]),  .pe_rst_seq(sys_rst_seq6),  .right_out(left_seq6[107:99]), .bottom_out(top_seq1[55:48]),  .acc(arr_out[0][5]));
PE pe_0_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6),  .left_in(left_seq6[107:99]), .top_in(     top[47:40]),  .pe_rst_seq(sys_rst_seq7),  .right_out(left_seq7[107:99]), .bottom_out(top_seq1[47:40]),  .acc(arr_out[0][6]));
PE pe_0_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq7[107:99]), .top_in(     top[39:32]),  .pe_rst_seq(sys_rst_seq8),  .right_out(left_seq8[107:99]), .bottom_out(top_seq1[39:32]),  .acc(arr_out[0][7]));
PE pe_0_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq8[107:99]), .top_in(     top[31:24]),  .pe_rst_seq(sys_rst_seq9),  .right_out(left_seq9[107:99]), .bottom_out(top_seq1[31:24]),  .acc(arr_out[0][8]));
PE pe_0_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq9[107:99]), .top_in(     top[23:16]),  .pe_rst_seq(sys_rst_seq10), .right_out(left_seq10[107:99]),.bottom_out(top_seq1[23:16]),  .acc(arr_out[0][9]));
PE pe_0_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq10[107:99]),.top_in(     top[15: 8]),  .pe_rst_seq(sys_rst_seq11), .right_out(left_seq11[107:99]),.bottom_out(top_seq1[15: 8]),  .acc(arr_out[0][10]));
PE pe_0_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq11[107:99]),.top_in(     top[ 7: 0]),  .pe_rst_seq(sys_rst_seq12), .right_out(     right[107:99]),.bottom_out(top_seq1[ 7: 0]),  .acc(arr_out[0][11]));

PE pe_1_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq1),  .left_in(left_seq0[98:90]),  .top_in(top_seq1[95:88]),  .pe_rst_seq(            ),  .right_out(left_seq1[98:90]),  .bottom_out(top_seq2[95:88]),  .acc(arr_out[1][0]));
PE pe_1_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq2),  .left_in(left_seq1[98:90]),  .top_in(top_seq1[87:80]),  .pe_rst_seq(            ),  .right_out(left_seq2[98:90]),  .bottom_out(top_seq2[87:80]),  .acc(arr_out[1][1]));
PE pe_1_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3),  .left_in(left_seq2[98:90]),  .top_in(top_seq1[79:72]),  .pe_rst_seq(            ),  .right_out(left_seq3[98:90]),  .bottom_out(top_seq2[79:72]),  .acc(arr_out[1][2]));
PE pe_1_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4),  .left_in(left_seq3[98:90]),  .top_in(top_seq1[71:64]),  .pe_rst_seq(            ),  .right_out(left_seq4[98:90]),  .bottom_out(top_seq2[71:64]),  .acc(arr_out[1][3]));
PE pe_1_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5),  .left_in(left_seq4[98:90]),  .top_in(top_seq1[63:56]),  .pe_rst_seq(            ),  .right_out(left_seq5[98:90]),  .bottom_out(top_seq2[63:56]),  .acc(arr_out[1][4]));
PE pe_1_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6),  .left_in(left_seq5[98:90]),  .top_in(top_seq1[55:48]),  .pe_rst_seq(            ),  .right_out(left_seq6[98:90]),  .bottom_out(top_seq2[55:48]),  .acc(arr_out[1][5]));
PE pe_1_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq6[98:90]),  .top_in(top_seq1[47:40]),  .pe_rst_seq(            ),  .right_out(left_seq7[98:90]),  .bottom_out(top_seq2[47:40]),  .acc(arr_out[1][6]));
PE pe_1_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq7[98:90]),  .top_in(top_seq1[39:32]),  .pe_rst_seq(            ),  .right_out(left_seq8[98:90]),  .bottom_out(top_seq2[39:32]),  .acc(arr_out[1][7]));
PE pe_1_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq8[98:90]),  .top_in(top_seq1[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[98:90]),  .bottom_out(top_seq2[31:24]),  .acc(arr_out[1][8]));
PE pe_1_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq9[98:90]),  .top_in(top_seq1[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[98:90]), .bottom_out(top_seq2[23:16]),  .acc(arr_out[1][9]));
PE pe_1_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq10[98:90]), .top_in(top_seq1[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[98:90]), .bottom_out(top_seq2[15: 8]),  .acc(arr_out[1][10]));
PE pe_1_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq11[98:90]), .top_in(top_seq1[ 7: 0]),  .pe_rst_seq(sys_rst_seq13), .right_out(     right[98:90]), .bottom_out(top_seq2[7: 0]),   .acc(arr_out[1][11]));

PE pe_2_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq2),  .left_in(left_seq0[89:81]),  .top_in(top_seq2[95:88]),  .pe_rst_seq(            ),  .right_out(left_seq1[89:81]),  .bottom_out(top_seq3[95:88]),  .acc(arr_out[2][0]));
PE pe_2_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3),  .left_in(left_seq1[89:81]),  .top_in(top_seq2[87:80]),  .pe_rst_seq(            ),  .right_out(left_seq2[89:81]),  .bottom_out(top_seq3[87:80]),  .acc(arr_out[2][1]));
PE pe_2_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4),  .left_in(left_seq2[89:81]),  .top_in(top_seq2[79:72]),  .pe_rst_seq(            ),  .right_out(left_seq3[89:81]),  .bottom_out(top_seq3[79:72]),  .acc(arr_out[2][2]));
PE pe_2_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5),  .left_in(left_seq3[89:81]),  .top_in(top_seq2[71:64]),  .pe_rst_seq(            ),  .right_out(left_seq4[89:81]),  .bottom_out(top_seq3[71:64]),  .acc(arr_out[2][3]));
PE pe_2_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6),  .left_in(left_seq4[89:81]),  .top_in(top_seq2[63:56]),  .pe_rst_seq(            ),  .right_out(left_seq5[89:81]),  .bottom_out(top_seq3[63:56]),  .acc(arr_out[2][4]));
PE pe_2_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq5[89:81]),  .top_in(top_seq2[55:48]),  .pe_rst_seq(            ),  .right_out(left_seq6[89:81]),  .bottom_out(top_seq3[55:48]),  .acc(arr_out[2][5]));
PE pe_2_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq6[89:81]),  .top_in(top_seq2[47:40]),  .pe_rst_seq(            ),  .right_out(left_seq7[89:81]),  .bottom_out(top_seq3[47:40]),  .acc(arr_out[2][6]));
PE pe_2_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq7[89:81]),  .top_in(top_seq2[39:32]),  .pe_rst_seq(             ), .right_out(left_seq8[89:81]),  .bottom_out(top_seq3[39:32]),  .acc(arr_out[2][7]));
PE pe_2_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq8[89:81]),  .top_in(top_seq2[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[89:81]),  .bottom_out(top_seq3[31:24]),  .acc(arr_out[2][8]));
PE pe_2_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq9[89:81]),  .top_in(top_seq2[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[89:81]), .bottom_out(top_seq3[23:16]),  .acc(arr_out[2][9]));
PE pe_2_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq10[89:81]), .top_in(top_seq2[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[89:81]), .bottom_out(top_seq3[15: 8]),  .acc(arr_out[2][10]));
PE pe_2_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq11[89:81]), .top_in(top_seq2[ 7: 0]),  .pe_rst_seq(sys_rst_seq14), .right_out(     right[89:81]), .bottom_out(top_seq3[ 7: 0]),  .acc(arr_out[2][11]));

PE pe_3_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3),  .left_in(left_seq0[80:72]),  .top_in(top_seq3[95:88]),  .pe_rst_seq(            ),  .right_out(left_seq1[80:72]),  .bottom_out(top_seq4[95:88]),  .acc(arr_out[3][0]));
PE pe_3_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4),  .left_in(left_seq1[80:72]),  .top_in(top_seq3[87:80]),  .pe_rst_seq(            ),  .right_out(left_seq2[80:72]),  .bottom_out(top_seq4[87:80]),  .acc(arr_out[3][1]));
PE pe_3_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5),  .left_in(left_seq2[80:72]),  .top_in(top_seq3[79:72]),  .pe_rst_seq(            ),  .right_out(left_seq3[80:72]),  .bottom_out(top_seq4[79:72]),  .acc(arr_out[3][2]));
PE pe_3_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6),  .left_in(left_seq3[80:72]),  .top_in(top_seq3[71:64]),  .pe_rst_seq(            ),  .right_out(left_seq4[80:72]),  .bottom_out(top_seq4[71:64]),  .acc(arr_out[3][3]));
PE pe_3_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq4[80:72]),  .top_in(top_seq3[63:56]),  .pe_rst_seq(            ),  .right_out(left_seq5[80:72]),  .bottom_out(top_seq4[63:56]),  .acc(arr_out[3][4]));
PE pe_3_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq5[80:72]),  .top_in(top_seq3[55:48]),  .pe_rst_seq(            ),  .right_out(left_seq6[80:72]),  .bottom_out(top_seq4[55:48]),  .acc(arr_out[3][5]));
PE pe_3_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq6[80:72]),  .top_in(top_seq3[47:40]),  .pe_rst_seq(             ), .right_out(left_seq7[80:72]),  .bottom_out(top_seq4[47:40]),  .acc(arr_out[3][6]));
PE pe_3_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq7[80:72]),  .top_in(top_seq3[39:32]),  .pe_rst_seq(             ), .right_out(left_seq8[80:72]),  .bottom_out(top_seq4[39:32]),  .acc(arr_out[3][7]));
PE pe_3_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq8[80:72]),  .top_in(top_seq3[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[80:72]),  .bottom_out(top_seq4[31:24]),  .acc(arr_out[3][8]));
PE pe_3_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq9[80:72]),  .top_in(top_seq3[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[80:72]), .bottom_out(top_seq4[23:16]),  .acc(arr_out[3][9]));
PE pe_3_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq10[80:72]), .top_in(top_seq3[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[80:72]), .bottom_out(top_seq4[15: 8]),  .acc(arr_out[3][10]));
PE pe_3_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq14), .left_in(left_seq11[80:72]), .top_in(top_seq3[ 7: 0]),  .pe_rst_seq(sys_rst_seq15), .right_out(     right[80:72]), .bottom_out(top_seq4[ 7: 0]),  .acc(arr_out[3][11]));

PE pe_4_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4),  .left_in(left_seq0[71:63]),  .top_in(top_seq4[95:88]),  .pe_rst_seq(            ),  .right_out(left_seq1[71:63]),  .bottom_out(top_seq5[95:88]),  .acc(arr_out[4][0]));
PE pe_4_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5),  .left_in(left_seq1[71:63]),  .top_in(top_seq4[87:80]),  .pe_rst_seq(            ),  .right_out(left_seq2[71:63]),  .bottom_out(top_seq5[87:80]),  .acc(arr_out[4][1]));
PE pe_4_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6),  .left_in(left_seq2[71:63]),  .top_in(top_seq4[79:72]),  .pe_rst_seq(            ),  .right_out(left_seq3[71:63]),  .bottom_out(top_seq5[79:72]),  .acc(arr_out[4][2]));
PE pe_4_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq3[71:63]),  .top_in(top_seq4[71:64]),  .pe_rst_seq(            ),  .right_out(left_seq4[71:63]),  .bottom_out(top_seq5[71:64]),  .acc(arr_out[4][3]));
PE pe_4_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq4[71:63]),  .top_in(top_seq4[63:56]),  .pe_rst_seq(            ),  .right_out(left_seq5[71:63]),  .bottom_out(top_seq5[63:56]),  .acc(arr_out[4][4]));
PE pe_4_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq5[71:63]),  .top_in(top_seq4[55:48]),  .pe_rst_seq(            ), .right_out(left_seq6[71:63]),  .bottom_out(top_seq5[55:48]),  .acc(arr_out[4][5]));
PE pe_4_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq6[71:63]),  .top_in(top_seq4[47:40]),  .pe_rst_seq(            ), .right_out(left_seq7[71:63]),  .bottom_out(top_seq5[47:40]),  .acc(arr_out[4][6]));
PE pe_4_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq7[71:63]),  .top_in(top_seq4[39:32]),  .pe_rst_seq(            ), .right_out(left_seq8[71:63]),  .bottom_out(top_seq5[39:32]),  .acc(arr_out[4][7]));
PE pe_4_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq8[71:63]),  .top_in(top_seq4[31:24]),  .pe_rst_seq(            ), .right_out(left_seq9[71:63]),  .bottom_out(top_seq5[31:24]),  .acc(arr_out[4][8]));
PE pe_4_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq9[71:63]),  .top_in(top_seq4[23:16]),  .pe_rst_seq(            ), .right_out(left_seq10[71:63]), .bottom_out(top_seq5[23:16]),  .acc(arr_out[4][9]));
PE pe_4_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq14), .left_in(left_seq10[71:63]), .top_in(top_seq4[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[71:63]), .bottom_out(top_seq5[15: 8]),  .acc(arr_out[4][10]));
PE pe_4_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq15), .left_in(left_seq11[71:63]), .top_in(top_seq4[ 7: 0]),  .pe_rst_seq(sys_rst_seq16), .right_out(     right[71:63]), .bottom_out(top_seq5[ 7: 0]),  .acc(arr_out[4][11]));

PE pe_5_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5),  .left_in(left_seq0[62:54]),  .top_in(top_seq5[95:88]),  .pe_rst_seq(            ),  .right_out(left_seq1[62:54]),  .bottom_out(top_seq6[95:88]),  .acc(arr_out[5][0]));
PE pe_5_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6),  .left_in(left_seq1[62:54]),  .top_in(top_seq5[87:80]),  .pe_rst_seq(            ),  .right_out(left_seq2[62:54]),  .bottom_out(top_seq6[87:80]),  .acc(arr_out[5][1]));
PE pe_5_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq2[62:54]),  .top_in(top_seq5[79:72]),  .pe_rst_seq(            ),  .right_out(left_seq3[62:54]),  .bottom_out(top_seq6[79:72]),  .acc(arr_out[5][2]));
PE pe_5_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq3[62:54]),  .top_in(top_seq5[71:64]),  .pe_rst_seq(            ),  .right_out(left_seq4[62:54]),  .bottom_out(top_seq6[71:64]),  .acc(arr_out[5][3]));
PE pe_5_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq4[62:54]),  .top_in(top_seq5[63:56]),  .pe_rst_seq(             ), .right_out(left_seq5[62:54]),  .bottom_out(top_seq6[63:56]),  .acc(arr_out[5][4]));
PE pe_5_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq5[62:54]),  .top_in(top_seq5[55:48]),  .pe_rst_seq(             ), .right_out(left_seq6[62:54]),  .bottom_out(top_seq6[55:48]),  .acc(arr_out[5][5]));
PE pe_5_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq6[62:54]),  .top_in(top_seq5[47:40]),  .pe_rst_seq(             ), .right_out(left_seq7[62:54]),  .bottom_out(top_seq6[47:40]),  .acc(arr_out[5][6]));
PE pe_5_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq7[62:54]),  .top_in(top_seq5[39:32]),  .pe_rst_seq(             ), .right_out(left_seq8[62:54]),  .bottom_out(top_seq6[39:32]),  .acc(arr_out[5][7]));
PE pe_5_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq8[62:54]),  .top_in(top_seq5[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[62:54]),  .bottom_out(top_seq6[31:24]),  .acc(arr_out[5][8]));
PE pe_5_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq14), .left_in(left_seq9[62:54]),  .top_in(top_seq5[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[62:54]), .bottom_out(top_seq6[23:16]),  .acc(arr_out[5][9]));
PE pe_5_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq15), .left_in(left_seq10[62:54]), .top_in(top_seq5[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[62:54]), .bottom_out(top_seq6[15: 8]),  .acc(arr_out[5][10]));
PE pe_5_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq16), .left_in(left_seq11[62:54]), .top_in(top_seq5[ 7: 0]),  .pe_rst_seq(sys_rst_seq17), .right_out(     right[62:54]), .bottom_out(top_seq6[7: 0]),   .acc(arr_out[5][11]));

PE pe_6_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6),  .left_in(left_seq0[53:45]),  .top_in(top_seq6[95:88]),  .pe_rst_seq(            ),  .right_out(left_seq1[53:45]),  .bottom_out(top_seq7[95:88]),  .acc(arr_out[6][0]));
PE pe_6_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq1[53:45]),  .top_in(top_seq6[87:80]),  .pe_rst_seq(            ),  .right_out(left_seq2[53:45]),  .bottom_out(top_seq7[87:80]),  .acc(arr_out[6][1]));
PE pe_6_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq2[53:45]),  .top_in(top_seq6[79:72]),  .pe_rst_seq(            ),  .right_out(left_seq3[53:45]),  .bottom_out(top_seq7[79:72]),  .acc(arr_out[6][2]));
PE pe_6_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq3[53:45]),  .top_in(top_seq6[71:64]),  .pe_rst_seq(             ), .right_out(left_seq4[53:45]),  .bottom_out(top_seq7[71:64]),  .acc(arr_out[6][3]));
PE pe_6_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq4[53:45]),  .top_in(top_seq6[63:56]),  .pe_rst_seq(             ), .right_out(left_seq5[53:45]),  .bottom_out(top_seq7[63:56]),  .acc(arr_out[6][4]));
PE pe_6_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq5[53:45]),  .top_in(top_seq6[55:48]),  .pe_rst_seq(             ), .right_out(left_seq6[53:45]),  .bottom_out(top_seq7[55:48]),  .acc(arr_out[6][5]));
PE pe_6_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq6[53:45]),  .top_in(top_seq6[47:40]),  .pe_rst_seq(             ), .right_out(left_seq7[53:45]),  .bottom_out(top_seq7[47:40]),  .acc(arr_out[6][6]));
PE pe_6_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq7[53:45]),  .top_in(top_seq6[39:32]),  .pe_rst_seq(             ), .right_out(left_seq8[53:45]),  .bottom_out(top_seq7[39:32]),  .acc(arr_out[6][7]));
PE pe_6_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq14), .left_in(left_seq8[53:45]),  .top_in(top_seq6[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[53:45]),  .bottom_out(top_seq7[31:24]),  .acc(arr_out[6][8]));
PE pe_6_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq15), .left_in(left_seq9[53:45]),  .top_in(top_seq6[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[53:45]), .bottom_out(top_seq7[23:16]),  .acc(arr_out[6][9]));
PE pe_6_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq16), .left_in(left_seq10[53:45]), .top_in(top_seq6[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[53:45]), .bottom_out(top_seq7[15: 8]),  .acc(arr_out[6][10]));
PE pe_6_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq17), .left_in(left_seq11[53:45]), .top_in(top_seq6[ 7: 0]),  .pe_rst_seq(sys_rst_seq18), .right_out(     right[53:45]), .bottom_out(top_seq7[ 7: 0]),  .acc(arr_out[6][11]));

PE pe_7_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq7),  .left_in(left_seq0[44:36]),  .top_in(top_seq7[95:88]),  .pe_rst_seq(            ),  .right_out(left_seq1[44:36]),  .bottom_out(top_seq8[95:88]),  .acc(arr_out[7][0]));
PE pe_7_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq1[44:36]),  .top_in(top_seq7[87:80]),  .pe_rst_seq(            ),  .right_out(left_seq2[44:36]),  .bottom_out(top_seq8[87:80]),  .acc(arr_out[7][1]));
PE pe_7_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq2[44:36]),  .top_in(top_seq7[79:72]),  .pe_rst_seq(             ), .right_out(left_seq3[44:36]),  .bottom_out(top_seq8[79:72]),  .acc(arr_out[7][2]));
PE pe_7_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq3[44:36]),  .top_in(top_seq7[71:64]),  .pe_rst_seq(             ), .right_out(left_seq4[44:36]),  .bottom_out(top_seq8[71:64]),  .acc(arr_out[7][3]));
PE pe_7_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq4[44:36]),  .top_in(top_seq7[63:56]),  .pe_rst_seq(             ), .right_out(left_seq5[44:36]),  .bottom_out(top_seq8[63:56]),  .acc(arr_out[7][4]));
PE pe_7_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq5[44:36]),  .top_in(top_seq7[55:48]),  .pe_rst_seq(             ), .right_out(left_seq6[44:36]),  .bottom_out(top_seq8[55:48]),  .acc(arr_out[7][5]));
PE pe_7_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq6[44:36]),  .top_in(top_seq7[47:40]),  .pe_rst_seq(             ), .right_out(left_seq7[44:36]),  .bottom_out(top_seq8[47:40]),  .acc(arr_out[7][6]));
PE pe_7_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq14), .left_in(left_seq7[44:36]),  .top_in(top_seq7[39:32]),  .pe_rst_seq(             ), .right_out(left_seq8[44:36]),  .bottom_out(top_seq8[39:32]),  .acc(arr_out[7][7]));
PE pe_7_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq15), .left_in(left_seq8[44:36]),  .top_in(top_seq7[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[44:36]),  .bottom_out(top_seq8[31:24]),  .acc(arr_out[7][8]));
PE pe_7_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq16), .left_in(left_seq9[44:36]),  .top_in(top_seq7[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[44:36]), .bottom_out(top_seq8[23:16]),  .acc(arr_out[7][9]));
PE pe_7_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq17), .left_in(left_seq10[44:36]), .top_in(top_seq7[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[44:36]), .bottom_out(top_seq8[15: 8]),  .acc(arr_out[7][10]));
PE pe_7_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq18), .left_in(left_seq11[44:36]), .top_in(top_seq7[ 7: 0]),  .pe_rst_seq(sys_rst_seq19), .right_out(     right[44:36]), .bottom_out(top_seq8[ 7: 0]),  .acc(arr_out[7][11]));

PE pe_8_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq8),  .left_in(left_seq0[35:27]),  .top_in(top_seq8[95:88]),  .pe_rst_seq(             ),  .right_out(left_seq1[35:27]),  .bottom_out(top_seq9[95:88]),  .acc(arr_out[8][0]));
PE pe_8_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq1[35:27]),  .top_in(top_seq8[87:80]),  .pe_rst_seq(             ), .right_out(left_seq2[35:27]),  .bottom_out(top_seq9[87:80]),  .acc(arr_out[8][1]));
PE pe_8_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq2[35:27]),  .top_in(top_seq8[79:72]),  .pe_rst_seq(             ), .right_out(left_seq3[35:27]),  .bottom_out(top_seq9[79:72]),  .acc(arr_out[8][2]));
PE pe_8_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq3[35:27]),  .top_in(top_seq8[71:64]),  .pe_rst_seq(             ), .right_out(left_seq4[35:27]),  .bottom_out(top_seq9[71:64]),  .acc(arr_out[8][3]));
PE pe_8_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq4[35:27]),  .top_in(top_seq8[63:56]),  .pe_rst_seq(             ), .right_out(left_seq5[35:27]),  .bottom_out(top_seq9[63:56]),  .acc(arr_out[8][4]));
PE pe_8_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq5[35:27]),  .top_in(top_seq8[55:48]),  .pe_rst_seq(             ), .right_out(left_seq6[35:27]),  .bottom_out(top_seq9[55:48]),  .acc(arr_out[8][5]));
PE pe_8_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq14), .left_in(left_seq6[35:27]),  .top_in(top_seq8[47:40]),  .pe_rst_seq(             ), .right_out(left_seq7[35:27]),  .bottom_out(top_seq9[47:40]),  .acc(arr_out[8][6]));
PE pe_8_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq15), .left_in(left_seq7[35:27]),  .top_in(top_seq8[39:32]),  .pe_rst_seq(             ), .right_out(left_seq8[35:27]),  .bottom_out(top_seq9[39:32]),  .acc(arr_out[8][7]));
PE pe_8_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq16), .left_in(left_seq8[35:27]),  .top_in(top_seq8[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[35:27]),  .bottom_out(top_seq9[31:24]),  .acc(arr_out[8][8]));
PE pe_8_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq17), .left_in(left_seq9[35:27]),  .top_in(top_seq8[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[35:27]), .bottom_out(top_seq9[23:16]),  .acc(arr_out[8][9]));
PE pe_8_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq18), .left_in(left_seq10[35:27]), .top_in(top_seq8[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[35:27]), .bottom_out(top_seq9[15: 8]),  .acc(arr_out[8][10]));
PE pe_8_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq19), .left_in(left_seq11[35:27]), .top_in(top_seq8[ 7: 0]),  .pe_rst_seq(sys_rst_seq20), .right_out(     right[35:27]), .bottom_out(top_seq9[ 7: 0]),  .acc(arr_out[8][11]));

PE pe_9_0(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq9),  .left_in(left_seq0[26:18]),  .top_in(top_seq9[95:88]),  .pe_rst_seq(             ), .right_out(left_seq1[26:18]),  .bottom_out(top_seq10[95:88]), .acc(arr_out[9][0]));
PE pe_9_1(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq10), .left_in(left_seq1[26:18]),  .top_in(top_seq9[87:80]),  .pe_rst_seq(             ), .right_out(left_seq2[26:18]),  .bottom_out(top_seq10[87:80]), .acc(arr_out[9][1]));
PE pe_9_2(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq11), .left_in(left_seq2[26:18]),  .top_in(top_seq9[79:72]),  .pe_rst_seq(             ), .right_out(left_seq3[26:18]),  .bottom_out(top_seq10[79:72]), .acc(arr_out[9][2]));
PE pe_9_3(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq12), .left_in(left_seq3[26:18]),  .top_in(top_seq9[71:64]),  .pe_rst_seq(             ), .right_out(left_seq4[26:18]),  .bottom_out(top_seq10[71:64]), .acc(arr_out[9][3]));
PE pe_9_4(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq13), .left_in(left_seq4[26:18]),  .top_in(top_seq9[63:56]),  .pe_rst_seq(             ), .right_out(left_seq5[26:18]),  .bottom_out(top_seq10[63:56]), .acc(arr_out[9][4]));
PE pe_9_5(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq14), .left_in(left_seq5[26:18]),  .top_in(top_seq9[55:48]),  .pe_rst_seq(             ), .right_out(left_seq6[26:18]),  .bottom_out(top_seq10[55:48]), .acc(arr_out[9][5]));
PE pe_9_6(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq15), .left_in(left_seq6[26:18]),  .top_in(top_seq9[47:40]),  .pe_rst_seq(             ), .right_out(left_seq7[26:18]),  .bottom_out(top_seq10[47:40]), .acc(arr_out[9][6]));
PE pe_9_7(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq16), .left_in(left_seq7[26:18]),  .top_in(top_seq9[39:32]),  .pe_rst_seq(             ), .right_out(left_seq8[26:18]),  .bottom_out(top_seq10[39:32]), .acc(arr_out[9][7]));
PE pe_9_8(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq17), .left_in(left_seq8[26:18]),  .top_in(top_seq9[31:24]),  .pe_rst_seq(             ), .right_out(left_seq9[26:18]),  .bottom_out(top_seq10[31:24]), .acc(arr_out[9][8]));
PE pe_9_9(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq18), .left_in(left_seq9[26:18]),  .top_in(top_seq9[23:16]),  .pe_rst_seq(             ), .right_out(left_seq10[26:18]), .bottom_out(top_seq10[23:16]), .acc(arr_out[9][9]));
PE pe_9_10(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq19), .left_in(left_seq10[26:18]), .top_in(top_seq9[15: 8]),  .pe_rst_seq(             ), .right_out(left_seq11[26:18]), .bottom_out(top_seq10[15: 8]), .acc(arr_out[9][10]));
PE pe_9_11(.clk(clk),.rst_n(rst_n), .pe_rst(sys_rst_seq20), .left_in(left_seq11[26:18]), .top_in(top_seq9[ 7: 0]),  .pe_rst_seq(sys_rst_seq21), .right_out(     right[26:18]), .bottom_out(top_seq10[7: 0]),  .acc(arr_out[9][11]));

PE pe_10_0(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq10), .left_in(left_seq0[17: 9]),  .top_in(top_seq10[95:88]), .pe_rst_seq(             ), .right_out(left_seq1[17: 9]),  .bottom_out(top_seq11[95:88]), .acc(arr_out[10][0]));
PE pe_10_1(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq1[17: 9]),  .top_in(top_seq10[87:80]), .pe_rst_seq(             ), .right_out(left_seq2[17: 9]),  .bottom_out(top_seq11[87:80]), .acc(arr_out[10][1]));
PE pe_10_2(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq2[17: 9]),  .top_in(top_seq10[79:72]), .pe_rst_seq(             ), .right_out(left_seq3[17: 9]),  .bottom_out(top_seq11[79:72]), .acc(arr_out[10][2]));
PE pe_10_3(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq3[17: 9]),  .top_in(top_seq10[71:64]), .pe_rst_seq(             ), .right_out(left_seq4[17: 9]),  .bottom_out(top_seq11[71:64]), .acc(arr_out[10][3]));
PE pe_10_4(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq4[17: 9]),  .top_in(top_seq10[63:56]), .pe_rst_seq(             ), .right_out(left_seq5[17: 9]),  .bottom_out(top_seq11[63:56]), .acc(arr_out[10][4]));
PE pe_10_5(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq5[17: 9]),  .top_in(top_seq10[55:48]), .pe_rst_seq(             ), .right_out(left_seq6[17: 9]),  .bottom_out(top_seq11[55:48]), .acc(arr_out[10][5]));
PE pe_10_6(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq6[17: 9]),  .top_in(top_seq10[47:40]), .pe_rst_seq(             ), .right_out(left_seq7[17: 9]),  .bottom_out(top_seq11[47:40]), .acc(arr_out[10][6]));
PE pe_10_7(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq7[17: 9]),  .top_in(top_seq10[39:32]), .pe_rst_seq(             ), .right_out(left_seq8[17: 9]),  .bottom_out(top_seq11[39:32]), .acc(arr_out[10][7]));
PE pe_10_8(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq8[17: 9]),  .top_in(top_seq10[31:24]), .pe_rst_seq(             ), .right_out(left_seq9[17: 9]),  .bottom_out(top_seq11[31:24]), .acc(arr_out[10][8]));
PE pe_10_9(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq9[17: 9]),  .top_in(top_seq10[23:16]), .pe_rst_seq(             ), .right_out(left_seq10[17: 9]), .bottom_out(top_seq11[23:16]), .acc(arr_out[10][9]));
PE pe_10_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq10[17: 9]), .top_in(top_seq10[15: 8]), .pe_rst_seq(             ), .right_out(left_seq11[17: 9]), .bottom_out(top_seq11[15: 8]), .acc(arr_out[10][10]));
PE pe_10_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq11[17: 9]), .top_in(top_seq10[ 7: 0]), .pe_rst_seq(sys_rst_seq22), .right_out(     right[17: 9]), .bottom_out(top_seq11[ 7: 0]), .acc(arr_out[10][11]));

PE pe_11_0(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq11), .left_in(left_seq0[ 8: 0]),  .top_in(top_seq11[95:88]), .pe_rst_seq(             ), .right_out(left_seq1[ 8: 0]),  .bottom_out(   bottom[95:88]), .acc(arr_out[11][0]));
PE pe_11_1(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq12), .left_in(left_seq1[ 8: 0]),  .top_in(top_seq11[87:80]), .pe_rst_seq(             ), .right_out(left_seq2[ 8: 0]),  .bottom_out(   bottom[87:80]), .acc(arr_out[11][1]));
PE pe_11_2(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq13), .left_in(left_seq2[ 8: 0]),  .top_in(top_seq11[79:72]), .pe_rst_seq(             ), .right_out(left_seq3[ 8: 0]),  .bottom_out(   bottom[79:72]), .acc(arr_out[11][2]));
PE pe_11_3(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq14), .left_in(left_seq3[ 8: 0]),  .top_in(top_seq11[71:64]), .pe_rst_seq(             ), .right_out(left_seq4[ 8: 0]),  .bottom_out(   bottom[71:64]), .acc(arr_out[11][3]));
PE pe_11_4(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq15), .left_in(left_seq4[ 8: 0]),  .top_in(top_seq11[63:56]), .pe_rst_seq(             ), .right_out(left_seq5[ 8: 0]),  .bottom_out(   bottom[63:56]), .acc(arr_out[11][4]));
PE pe_11_5(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq16), .left_in(left_seq5[ 8: 0]),  .top_in(top_seq11[55:48]), .pe_rst_seq(             ), .right_out(left_seq6[ 8: 0]),  .bottom_out(   bottom[55:48]), .acc(arr_out[11][5]));
PE pe_11_6(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq17), .left_in(left_seq6[ 8: 0]),  .top_in(top_seq11[47:40]), .pe_rst_seq(             ), .right_out(left_seq7[ 8: 0]),  .bottom_out(   bottom[47:40]), .acc(arr_out[11][6]));
PE pe_11_7(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq18), .left_in(left_seq7[ 8: 0]),  .top_in(top_seq11[39:32]), .pe_rst_seq(             ), .right_out(left_seq8[ 8: 0]),  .bottom_out(   bottom[39:32]), .acc(arr_out[11][7]));
PE pe_11_8(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq19), .left_in(left_seq8[ 8: 0]),  .top_in(top_seq11[31:24]), .pe_rst_seq(             ), .right_out(left_seq9[ 8: 0]),  .bottom_out(   bottom[31:24]), .acc(arr_out[11][8]));
PE pe_11_9(.clk(clk), .rst_n(rst_n),.pe_rst(sys_rst_seq20), .left_in(left_seq9[ 8: 0]),  .top_in(top_seq11[23:16]), .pe_rst_seq(             ), .right_out(left_seq10[ 8: 0]), .bottom_out(   bottom[23:16]), .acc(arr_out[11][9]));
PE pe_11_10(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq21), .left_in(left_seq10[ 8: 0]), .top_in(top_seq11[15: 8]), .pe_rst_seq(             ), .right_out(left_seq11[ 8: 0]), .bottom_out(   bottom[15: 8]), .acc(arr_out[11][10]));
PE pe_11_11(.clk(clk),.rst_n(rst_n),.pe_rst(sys_rst_seq22), .left_in(left_seq11[ 8: 0]), .top_in(top_seq11[ 7: 0]), .pe_rst_seq(sys_rst_seq23), .right_out(     right[ 8: 0]), .bottom_out(   bottom[ 7: 0]), .acc(arr_out[11][11]));

assign row0_out = {arr_out[0][0], arr_out[0][1], arr_out[0][2], arr_out[0][3], arr_out[0][4], arr_out[0][5], arr_out[0][6], arr_out[0][7], arr_out[0][8], arr_out[0][9], arr_out[0][10], arr_out[0][11]};
assign row1_out = {arr_out[1][0], arr_out[1][1], arr_out[1][2], arr_out[1][3], arr_out[1][4], arr_out[1][5], arr_out[1][6], arr_out[1][7], arr_out[1][8], arr_out[1][9], arr_out[1][10], arr_out[1][11]};
assign row2_out = {arr_out[2][0], arr_out[2][1], arr_out[2][2], arr_out[2][3], arr_out[2][4], arr_out[2][5], arr_out[2][6], arr_out[2][7], arr_out[2][8], arr_out[2][9], arr_out[2][10], arr_out[2][11]};
assign row3_out = {arr_out[3][0], arr_out[3][1], arr_out[3][2], arr_out[3][3], arr_out[3][4], arr_out[3][5], arr_out[3][6], arr_out[3][7], arr_out[3][8], arr_out[3][9], arr_out[3][10], arr_out[3][11]};
assign row4_out = {arr_out[4][0], arr_out[4][1], arr_out[4][2], arr_out[4][3], arr_out[4][4], arr_out[4][5], arr_out[4][6], arr_out[4][7], arr_out[4][8], arr_out[4][9], arr_out[4][10], arr_out[4][11]};
assign row5_out = {arr_out[5][0], arr_out[5][1], arr_out[5][2], arr_out[5][3], arr_out[5][4], arr_out[5][5], arr_out[5][6], arr_out[5][7], arr_out[5][8], arr_out[5][9], arr_out[5][10], arr_out[5][11]};
assign row6_out = {arr_out[6][0], arr_out[6][1], arr_out[6][2], arr_out[6][3], arr_out[6][4], arr_out[6][5], arr_out[6][6], arr_out[6][7], arr_out[6][8], arr_out[6][9], arr_out[6][10], arr_out[6][11]};
assign row7_out = {arr_out[7][0], arr_out[7][1], arr_out[7][2], arr_out[7][3], arr_out[7][4], arr_out[7][5], arr_out[7][6], arr_out[7][7], arr_out[7][8], arr_out[7][9], arr_out[7][10], arr_out[7][11]};
assign row8_out = {arr_out[8][0], arr_out[8][1], arr_out[8][2], arr_out[8][3], arr_out[8][4], arr_out[8][5], arr_out[8][6], arr_out[8][7], arr_out[8][8], arr_out[8][9], arr_out[8][10], arr_out[8][11]};
assign row9_out = {arr_out[9][0], arr_out[9][1], arr_out[9][2], arr_out[9][3], arr_out[9][4], arr_out[9][5], arr_out[9][6], arr_out[9][7], arr_out[9][8], arr_out[9][9], arr_out[9][10], arr_out[9][11]};
assign row10_out = {arr_out[10][0], arr_out[10][1], arr_out[10][2], arr_out[10][3], arr_out[10][4], arr_out[10][5], arr_out[10][6], arr_out[10][7], arr_out[10][8], arr_out[10][9], arr_out[10][10], arr_out[10][11]};
assign row11_out = {arr_out[11][0], arr_out[11][1], arr_out[11][2], arr_out[11][3], arr_out[11][4], arr_out[11][5], arr_out[11][6], arr_out[11][7], arr_out[11][8], arr_out[11][9], arr_out[11][10], arr_out[11][11]};

always @(posedge clk) begin
    if (!rst_n) begin
        out_valid_pp0 <= 0;
        out_valid_pp1 <= 0;
        out_valid_pp2 <= 0;
        out_valid_pp3 <= 0;
        out_valid_pp4 <= 0;
        out_valid_pp5 <= 0;
        out_valid_pp6 <= 0;
        out_valid_pp7 <= 0;
        out_valid_pp8 <= 0;
        out_valid_pp9 <= 0;
        out_valid <= 0;
    end
    else begin
        out_valid_pp0 <= in_valid;
        out_valid_pp1 <= out_valid_pp0;
        out_valid_pp2 <= out_valid_pp1;
        out_valid_pp3 <= out_valid_pp2;
        out_valid_pp4 <= out_valid_pp3;
        out_valid_pp5 <= out_valid_pp4;
        out_valid_pp6 <= out_valid_pp5;
        out_valid_pp7 <= out_valid_pp6;
        out_valid_pp8 <= out_valid_pp7;
        out_valid_pp9 <= out_valid_pp8;
        out_valid <= out_valid_pp9;
    end
end

endmodule


module SYS_4x4_ARRAY (
    clk,
    rst_n,
    in_valid,
    offset_valid,
    sys_rst_seq0,
    left,
    top,
    out_valid,
    row0_out,
    row1_out,
    row2_out,
    row3_out
);

// IO
input clk, rst_n;
input [3:0] in_valid;
input offset_valid;
input sys_rst_seq0;
input [31:0] left, top;

output reg [3:0] out_valid;
output wire [128:0] row0_out;
output wire [128:0] row1_out;
output wire [128:0] row2_out;
output wire [128:0] row3_out;

// Signals
wire sys_rst_seq1, sys_rst_seq2, sys_rst_seq3, sys_rst_seq4, sys_rst_seq5, sys_rst_seq6, sys_rst_seq7;
wire [35:0] left_seq0, left_seq1, left_seq2, left_seq3, right;
wire [31:0] top_seq1, top_seq2, top_seq3, bottom;

wire signed [8:0] left_offset0 = offset_valid ? $signed(left[31:24]) + 128 : $signed(left[31:24]);
wire signed [8:0] left_offset1 = offset_valid ? $signed(left[23:16]) + 128 : $signed(left[23:16]);
wire signed [8:0] left_offset2 = offset_valid ? $signed(left[15: 8]) + 128 : $signed(left[15: 8]);
wire signed [8:0] left_offset3 = offset_valid ? $signed(left[ 7: 0]) + 128 : $signed(left[ 7: 0]);
assign left_seq0 = {left_offset0[8:0], left_offset1[8:0], left_offset2[8:0], left_offset3[8:0]};

reg [3:0] out_valid_pp0, out_valid_pp1;

wire [31:0] arr_out [0:3][0:3];

// Design
// Signal naming is based on 0-indexing.
PE pe_00(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq0), .left_in(left_seq0[35:27]), .top_in(     top[31:24]), .pe_rst_seq(sys_rst_seq1), .right_out(left_seq1[35:27]), .bottom_out(top_seq1[31:24]), .acc(arr_out[0][0]));
PE pe_01(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq1), .left_in(left_seq1[35:27]), .top_in(     top[23:16]), .pe_rst_seq(sys_rst_seq2), .right_out(left_seq2[35:27]), .bottom_out(top_seq1[23:16]), .acc(arr_out[0][1]));
PE pe_02(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq2), .left_in(left_seq2[35:27]), .top_in(     top[15: 8]), .pe_rst_seq(sys_rst_seq3), .right_out(left_seq3[35:27]), .bottom_out(top_seq1[15: 8]), .acc(arr_out[0][2]));
PE pe_03(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3), .left_in(left_seq3[35:27]), .top_in(     top[ 7: 0]), .pe_rst_seq(sys_rst_seq4), .right_out(    right[35:27]), .bottom_out(top_seq1[ 7: 0]), .acc(arr_out[0][3]));

PE pe_10(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq1), .left_in(left_seq0[26:18]), .top_in(top_seq1[31:24]), .pe_rst_seq(sys_rst_seq2), .right_out(left_seq1[26:18]), .bottom_out(top_seq2[31:24]), .acc(arr_out[1][0]));
PE pe_11(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq2), .left_in(left_seq1[26:18]), .top_in(top_seq1[23:16]), .pe_rst_seq(sys_rst_seq3), .right_out(left_seq2[26:18]), .bottom_out(top_seq2[23:16]), .acc(arr_out[1][1]));
PE pe_12(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3), .left_in(left_seq2[26:18]), .top_in(top_seq1[15: 8]), .pe_rst_seq(sys_rst_seq4), .right_out(left_seq3[26:18]), .bottom_out(top_seq2[15: 8]), .acc(arr_out[1][2]));
PE pe_13(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4), .left_in(left_seq3[26:18]), .top_in(top_seq1[ 7: 0]), .pe_rst_seq(sys_rst_seq5), .right_out(    right[26:18]), .bottom_out(top_seq2[ 7: 0]), .acc(arr_out[1][3]));

PE pe_20(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq2), .left_in(left_seq0[17: 9]), .top_in(top_seq2[31:24]), .pe_rst_seq(sys_rst_seq3), .right_out(left_seq1[17: 9]), .bottom_out(top_seq3[31:24]), .acc(arr_out[2][0]));
PE pe_21(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3), .left_in(left_seq1[17: 9]), .top_in(top_seq2[23:16]), .pe_rst_seq(sys_rst_seq4), .right_out(left_seq2[17: 9]), .bottom_out(top_seq3[23:16]), .acc(arr_out[2][1]));
PE pe_22(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4), .left_in(left_seq2[17: 9]), .top_in(top_seq2[15: 8]), .pe_rst_seq(sys_rst_seq5), .right_out(left_seq3[17: 9]), .bottom_out(top_seq3[15: 8]), .acc(arr_out[2][2]));
PE pe_23(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5), .left_in(left_seq3[17: 9]), .top_in(top_seq2[ 7: 0]), .pe_rst_seq(sys_rst_seq6), .right_out(    right[17: 9]), .bottom_out(top_seq3[ 7: 0]), .acc(arr_out[2][3]));

PE pe_30(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq3), .left_in(left_seq0[ 8: 0]), .top_in(top_seq3[31:24]), .pe_rst_seq(sys_rst_seq4), .right_out(left_seq1[ 8: 0]), .bottom_out(  bottom[31:24]), .acc(arr_out[3][0]));
PE pe_31(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq4), .left_in(left_seq1[ 8: 0]), .top_in(top_seq3[23:16]), .pe_rst_seq(sys_rst_seq5), .right_out(left_seq2[ 8: 0]), .bottom_out(  bottom[23:16]), .acc(arr_out[3][1]));
PE pe_32(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq5), .left_in(left_seq2[ 8: 0]), .top_in(top_seq3[15: 8]), .pe_rst_seq(sys_rst_seq6), .right_out(left_seq3[ 8: 0]), .bottom_out(  bottom[15: 8]), .acc(arr_out[3][2]));
PE pe_33(.clk(clk), .rst_n(rst_n), .pe_rst(sys_rst_seq6), .left_in(left_seq3[ 8: 0]), .top_in(top_seq3[ 7: 0]), .pe_rst_seq(sys_rst_seq7), .right_out(    right[ 8: 0]), .bottom_out(  bottom[ 7: 0]), .acc(arr_out[3][3]));

assign row0_out = {arr_out[0][0], arr_out[0][1], arr_out[0][2], arr_out[0][3]};
assign row1_out = {arr_out[1][0], arr_out[1][1], arr_out[1][2], arr_out[1][3]};
assign row2_out = {arr_out[2][0], arr_out[2][1], arr_out[2][2], arr_out[2][3]};
assign row3_out = {arr_out[3][0], arr_out[3][1], arr_out[3][2], arr_out[3][3]};

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_valid_pp0 <= 0;
        out_valid_pp1 <= 0;
        out_valid <= 0;
    end
    else begin
        out_valid_pp0 <= in_valid;
        out_valid_pp1 <= out_valid_pp0;
        out_valid <= out_valid_pp1;
    end
end

endmodule
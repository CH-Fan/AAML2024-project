`include "systolic_array.v"

module TPU(
    clk,
    rst_n,

    in_valid,
    offset_valid,
    K,
    M,
    N,
    busy,

    A_wr_en,
    A_index,
    A_data_in,
    A_data_out,

    B_wr_en,
    B_index,
    B_data_in,
    B_data_out,

    C_wr_en,
    C_index,
    C_data_in,
    C_data_out
);


input             clk;
input             rst_n;
input             in_valid;
input             offset_valid;
input [9:0]       K;
input [10:0]      M;
input [8:0]       N;
output  reg       busy;

output            A_wr_en;
output reg [13:0] A_index;
output [127:0]     A_data_in;
input  [127:0]     A_data_out;

output            B_wr_en;
output reg [11:0] B_index;
output [127:0]     B_data_in;
input  [127:0]     B_data_out;

output            C_wr_en;
output [10:0]     C_index;
output [511:0]    C_data_in;
input  [511:0]    C_data_out;


reg [511:0] data_write;

// ========== FSM ==========
reg [1:0] state;
parameter IDLE = 0;
parameter FEED = 1;
parameter CALC = 3;


// ========== Signals ==========
reg [9:0] K_reg;
reg [9:0] k_times;
reg [9:0] cnt_k;

reg [10:0] M_reg;
reg [6:0] m_times, m_comb;
reg [6:0] cnt_m;
wire [10:0] m0 = {cnt_m, 4'h0};
wire [10:0] m1 = {cnt_m, 4'h1};
wire [10:0] m2 = {cnt_m, 4'h2};
wire [10:0] m3 = {cnt_m, 4'h3};
wire [10:0] m4 = {cnt_m, 4'h4};
wire [10:0] m5 = {cnt_m, 4'h5};
wire [10:0] m6 = {cnt_m, 4'h6};
wire [10:0] m7 = {cnt_m, 4'h7};
wire [10:0] m8 = {cnt_m, 4'h8};
wire [10:0] m9 = {cnt_m, 4'h9};
wire [10:0] m10= {cnt_m, 4'ha};
wire [10:0] m11= {cnt_m, 4'hb};
wire [10:0] m12= {cnt_m, 4'hc};
wire [10:0] m13= {cnt_m, 4'hd};
wire [10:0] m14= {cnt_m, 4'he};
wire [10:0] m15= {cnt_m, 4'hf};

reg [8:0] N_reg;
reg [2:0] n_times, n_comb;
reg [2:0] cnt_n;

reg cal_rst, sys_rst;

reg valid0, valid1, valid2, valid3, valid4, valid5, valid6, valid7, valid8, valid9, valid10, valid11, valid12, valid13, valid14, valid15;
reg valid1_ff0, valid2_ff0, valid3_ff0, valid4_ff0, valid5_ff0, valid6_ff0, valid7_ff0, valid8_ff0, valid9_ff0, valid10_ff0, valid11_ff0, valid12_ff0, valid13_ff0, valid14_ff0, valid15_ff0;
reg valid2_ff1, valid3_ff1, valid4_ff1, valid5_ff1, valid6_ff1, valid7_ff1, valid8_ff1, valid9_ff1, valid10_ff1, valid11_ff1, valid12_ff1, valid13_ff1, valid14_ff1, valid15_ff1;
reg valid3_ff2, valid4_ff2, valid5_ff2, valid6_ff2, valid7_ff2, valid8_ff2, valid9_ff2, valid10_ff2, valid11_ff2, valid12_ff2, valid13_ff2, valid14_ff2, valid15_ff2;
reg valid4_ff3, valid5_ff3, valid6_ff3, valid7_ff3, valid8_ff3, valid9_ff3, valid10_ff3, valid11_ff3, valid12_ff3, valid13_ff3, valid14_ff3, valid15_ff3;
reg valid5_ff4, valid6_ff4, valid7_ff4, valid8_ff4, valid9_ff4, valid10_ff4, valid11_ff4, valid12_ff4, valid13_ff4, valid14_ff4, valid15_ff4;
reg valid6_ff5, valid7_ff5, valid8_ff5, valid9_ff5, valid10_ff5, valid11_ff5, valid12_ff5, valid13_ff5, valid14_ff5, valid15_ff5;
reg valid7_ff6, valid8_ff6, valid9_ff6, valid10_ff6, valid11_ff6, valid12_ff6, valid13_ff6, valid14_ff6, valid15_ff6;
reg valid8_ff7, valid9_ff7, valid10_ff7, valid11_ff7, valid12_ff7, valid13_ff7, valid14_ff7, valid15_ff7;
reg valid9_ff8, valid10_ff8, valid11_ff8, valid12_ff8, valid13_ff8, valid14_ff8, valid15_ff8;
reg valid10_ff9, valid11_ff9, valid12_ff9, valid13_ff9, valid14_ff9, valid15_ff9;
reg valid11_ff10, valid12_ff10, valid13_ff10, valid14_ff10, valid15_ff10;
reg valid12_ff11, valid13_ff11, valid14_ff11, valid15_ff11;
reg valid13_ff12, valid14_ff12, valid15_ff12;
reg valid14_ff13, valid15_ff13;
reg valid15_ff14;
reg [7:0] row0, row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13, row14, row15;
reg [7:0] row1_ff0, row2_ff0, row3_ff0, row4_ff0, row5_ff0, row6_ff0, row7_ff0, row8_ff0, row9_ff0, row10_ff0, row11_ff0, row12_ff0, row13_ff0, row14_ff0, row15_ff0;
reg [7:0] row2_ff1, row3_ff1, row4_ff1, row5_ff1, row6_ff1, row7_ff1, row8_ff1, row9_ff1, row10_ff1, row11_ff1, row12_ff1, row13_ff1, row14_ff1, row15_ff1;
reg [7:0] row3_ff2, row4_ff2, row5_ff2, row6_ff2, row7_ff2, row8_ff2, row9_ff2, row10_ff2, row11_ff2, row12_ff2, row13_ff2, row14_ff2, row15_ff2;
reg [7:0] row4_ff3, row5_ff3, row6_ff3, row7_ff3, row8_ff3, row9_ff3, row10_ff3, row11_ff3, row12_ff3, row13_ff3, row14_ff3, row15_ff3;
reg [7:0] row5_ff4, row6_ff4, row7_ff4, row8_ff4, row9_ff4, row10_ff4, row11_ff4, row12_ff4, row13_ff4, row14_ff4, row15_ff4;
reg [7:0] row6_ff5, row7_ff5, row8_ff5, row9_ff5, row10_ff5, row11_ff5, row12_ff5, row13_ff5, row14_ff5, row15_ff5;
reg [7:0] row7_ff6, row8_ff6, row9_ff6, row10_ff6, row11_ff6, row12_ff6, row13_ff6, row14_ff6, row15_ff6;
reg [7:0] row8_ff7, row9_ff7, row10_ff7, row11_ff7, row12_ff7, row13_ff7, row14_ff7, row15_ff7;
reg [7:0] row9_ff8, row10_ff8, row11_ff8, row12_ff8, row13_ff8, row14_ff8, row15_ff8;
reg [7:0] row10_ff9, row11_ff9, row12_ff9, row13_ff9, row14_ff9, row15_ff9;
reg [7:0] row11_ff10, row12_ff10, row13_ff10, row14_ff10, row15_ff10;
reg [7:0] row12_ff11, row13_ff11, row14_ff11, row15_ff11;
reg [7:0] row13_ff12, row14_ff12, row15_ff12;
reg [7:0] row14_ff13, row15_ff13;
reg [7:0] row15_ff14;
reg [7:0] col0, col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, col11, col12, col13, col14, col15;
reg [7:0] col1_ff0, col2_ff0, col3_ff0, col4_ff0, col5_ff0, col6_ff0, col7_ff0, col8_ff0, col9_ff0, col10_ff0, col11_ff0, col12_ff0, col13_ff0, col14_ff0, col15_ff0;
reg [7:0] col2_ff1, col3_ff1, col4_ff1, col5_ff1, col6_ff1, col7_ff1, col8_ff1, col9_ff1, col10_ff1, col11_ff1, col12_ff1, col13_ff1, col14_ff1, col15_ff1;
reg [7:0] col3_ff2, col4_ff2, col5_ff2, col6_ff2, col7_ff2, col8_ff2, col9_ff2, col10_ff2, col11_ff2, col12_ff2, col13_ff2, col14_ff2, col15_ff2;
reg [7:0] col4_ff3, col5_ff3, col6_ff3, col7_ff3, col8_ff3, col9_ff3, col10_ff3, col11_ff3, col12_ff3, col13_ff3, col14_ff3, col15_ff3;
reg [7:0] col5_ff4, col6_ff4, col7_ff4, col8_ff4, col9_ff4, col10_ff4, col11_ff4, col12_ff4, col13_ff4, col14_ff4, col15_ff4;
reg [7:0] col6_ff5, col7_ff5, col8_ff5, col9_ff5, col10_ff5, col11_ff5, col12_ff5, col13_ff5, col14_ff5, col15_ff5;
reg [7:0] col7_ff6, col8_ff6, col9_ff6, col10_ff6, col11_ff6, col12_ff6, col13_ff6, col14_ff6, col15_ff6;
reg [7:0] col8_ff7, col9_ff7, col10_ff7, col11_ff7, col12_ff7, col13_ff7, col14_ff7, col15_ff7;
reg [7:0] col9_ff8, col10_ff8, col11_ff8, col12_ff8, col13_ff8, col14_ff8, col15_ff8;
reg [7:0] col10_ff9, col11_ff9, col12_ff9, col13_ff9, col14_ff9, col15_ff9;
reg [7:0] col11_ff10, col12_ff10, col13_ff10, col14_ff10, col15_ff10;
reg [7:0] col12_ff11, col13_ff11, col14_ff11, col15_ff11;
reg [7:0] col13_ff12, col14_ff12, col15_ff12;
reg [7:0] col14_ff13, col15_ff13;
reg [7:0] col15_ff14;
reg [15:0] valid_bus;
reg [127:0] a_bus, b_bus;
wire [15:0] out_valid;
wire [511:0] result0, result1, result2, result3, result4, result5, result6, result7, result8, result9, result10, result11, result12, result13, result14, result15;

wire eq_k, eq_m, eq_n;
reg grabbing;
wire end_feeding;
wire end_calculating;

reg eq_k_ff0, eq_k_ff1;
reg r0_done, r1_done, r2_done, r3_done, r4_done, r5_done, r6_done, r7_done, r8_done, r9_done, r10_done, r11_done, r12_done, r13_done, r14_done, r15_done;
reg [15:0] idx_c;
wire [15:0] write_valid;


// ========== State ==========
always @(posedge clk) begin
    if (!rst_n) state <= IDLE;
    else begin
        case (state)
        IDLE:   state <= in_valid ? FEED : IDLE;
        FEED:   state <= end_feeding ? CALC : FEED;
        CALC:   state <= end_calculating ? IDLE : CALC;
        endcase
    end
end

// ========== Registers ==========
always @(posedge clk) begin
    if (!rst_n) begin
        K_reg <= 0;
        M_reg <= 0;
        N_reg <= 0;
    end
    else begin
        K_reg <= in_valid ? K : K_reg;
        M_reg <= in_valid ? M : M_reg;
        N_reg <= in_valid ? N : N_reg;
    end
end

// always @(*) begin
//     case (M)
//     'd1024: m_comb = 'd85;
//     'd256:  m_comb = 'd21;
//     'd64:   m_comb = 'd5;
//     default:m_comb = 'd0;
//     endcase
//     case (N)
//     'd16:   n_comb = 'd1;
//     'd32:   n_comb = 'd2;
//     'd64:   n_comb = 'd5;
//     default:n_comb = 'd0;
//     endcase
// end

always @(posedge clk) begin
    if (!rst_n) begin
        k_times <= 0;
        m_times <= 0;
        n_times <= 0;
    end
    else begin
        if (in_valid) begin
            k_times <= K + 14;
            m_times <= M[3:0] == 4'h0 ? (M[10:4] - 1) : M[10:4];
            n_times <= N[3:0] == 4'h0 ? (N[ 8:4] - 1) : N[ 8:4];
        end
        else begin
            k_times <= k_times;
            m_times <= m_times;
            n_times <= n_times;
        end
    end
end

// ========== SRAM interface ==========
// Buffer A
assign A_wr_en = 0;
assign A_data_in = 0;
// assign A_index = cnt_m * K_reg + cnt_k;

// Buffer B
assign B_wr_en = 0;
assign B_data_in = 0;
// assign B_index = cnt_n * K_reg + cnt_k;

// Buffer C
assign write_valid = {(r0_done & out_valid[15]), (r1_done & out_valid[14]), (r2_done & out_valid[13]), (r3_done & out_valid[12]), (r4_done & out_valid[11]), (r5_done & out_valid[10]), (r6_done & out_valid[9]), (r7_done & out_valid[8]), (r8_done & out_valid[7]), (r9_done & out_valid[6]), (r10_done & out_valid[5]), (r11_done & out_valid[4]), (r12_done & out_valid[3]), (r13_done & out_valid[2]), (r14_done & out_valid[1]), (r15_done & out_valid[0])};
assign C_wr_en = |write_valid;
assign C_index = |write_valid ? idx_c : 0;
assign C_data_in = data_write;

always @(*) begin
    if (write_valid[15]) data_write = result0;
    else if (write_valid[14]) data_write = result1;
    else if (write_valid[13]) data_write = result2;
    else if (write_valid[12]) data_write = result3;
    else if (write_valid[11]) data_write = result4;
    else if (write_valid[10]) data_write = result5;
    else if (write_valid[9]) data_write = result6;
    else if (write_valid[8]) data_write = result7;
    else if (write_valid[7]) data_write = result8;
    else if (write_valid[6]) data_write = result9;
    else if (write_valid[5]) data_write = result10;
    else if (write_valid[4]) data_write = result11;
    else if (write_valid[3]) data_write = result12;
    else if (write_valid[2]) data_write = result13;
    else if (write_valid[1]) data_write = result14;
    else if (write_valid[0]) data_write = result15;
    else data_write = 'd0;
end

// ========== Design ==========
assign eq_k = cnt_k == k_times;
assign eq_m = cnt_m == m_times;
assign eq_n = cnt_n == n_times;
assign end_feeding = eq_k & eq_m & eq_n;
assign end_calculating = idx_c == M_reg * (n_times + 1);

always @(*) begin
    if (state == FEED) grabbing = cnt_k < K_reg;
    else grabbing = 0;
end

always @(posedge clk) begin
    if (!rst_n) begin
        cnt_k <= 0;
        cnt_m <= 0;
        cnt_n <= 0;

        A_index <= 0;
        B_index <= 0;
    end
    else begin
        if (in_valid) begin
            cnt_k <= 0;
            cnt_m <= 0;
            cnt_n <= 0;

            A_index <= 0;
            B_index <= 0;
        end
        else if (eq_k & eq_m & eq_n) begin
            cnt_k <= cnt_k;
            cnt_m <= cnt_m;
            cnt_n <= cnt_n;

            A_index <= A_index;
            B_index <= B_index;
        end
        else if (eq_k & eq_m) begin
            cnt_k <= 0;
            cnt_m <= 0;
            cnt_n <= cnt_n + 1;

            A_index <= 0;
            B_index <= B_index + 1;
        end
        else if (eq_k) begin
            cnt_k <= 0;
            cnt_m <= cnt_m + 1;
            cnt_n <= cnt_n;

            A_index <= A_index + 1;
            B_index <= B_index - (K_reg - 1);
        end
        else begin
            cnt_k <= cnt_k + 1;
            cnt_m <= cnt_m;
            cnt_n <= cnt_n;

            A_index <= cnt_k < K_reg-1 ? A_index + 1 : A_index;
            B_index <= cnt_k < K_reg-1 ? B_index + 1 : B_index;
        end
    end
end

always @(*) begin
    cal_rst = cnt_k == 0 ? 1 : 0;
    valid0 = (m0 < M_reg) ? 1 : 0;
    valid1 = (m1 < M_reg) ? 1 : 0;
    valid2 = (m2 < M_reg) ? 1 : 0;
    valid3 = (m3 < M_reg) ? 1 : 0;
    valid4 = (m4 < M_reg) ? 1 : 0;
    valid5 = (m5 < M_reg) ? 1 : 0;
    valid6 = (m6 < M_reg) ? 1 : 0;
    valid7 = (m7 < M_reg) ? 1 : 0;
    valid8 = (m8 < M_reg) ? 1 : 0;
    valid9 = (m9 < M_reg) ? 1 : 0;
    valid10= (m10< M_reg) ? 1 : 0;
    valid11= (m11< M_reg) ? 1 : 0;
    valid12= (m12< M_reg) ? 1 : 0;
    valid13= (m13< M_reg) ? 1 : 0;
    valid14= (m14< M_reg) ? 1 : 0;
    valid15= (m15< M_reg) ? 1 : 0;
end

always @(posedge clk) begin
    if (!rst_n) begin
        valid1_ff0 <= 0;  valid2_ff0 <= 0;   valid3_ff0 <= 0;  valid4_ff0 <= 0;  valid5_ff0 <= 0;  valid6_ff0 <= 0;  valid7_ff0 <= 0;  valid8_ff0 <= 0;  valid9_ff0 <= 0;  valid10_ff0 <= 0; valid11_ff0 <= 0; valid12_ff0 <= 0; valid13_ff0 <= 0; valid14_ff0 <= 0; valid15_ff0 <= 0;
        valid2_ff1 <= 0;  valid3_ff1 <= 0;   valid4_ff1 <= 0;  valid5_ff1 <= 0;  valid6_ff1 <= 0;  valid7_ff1 <= 0;  valid8_ff1 <= 0;  valid9_ff1 <= 0;  valid10_ff1 <= 0; valid11_ff1 <= 0; valid12_ff1 <= 0; valid13_ff1 <= 0; valid14_ff1 <= 0; valid15_ff1 <= 0;
        valid3_ff2 <= 0;  valid4_ff2 <= 0;   valid5_ff2 <= 0;  valid6_ff2 <= 0;  valid7_ff2 <= 0;  valid8_ff2 <= 0;  valid9_ff2 <= 0;  valid10_ff2 <= 0; valid11_ff2 <= 0; valid12_ff2 <= 0; valid13_ff2 <= 0; valid14_ff2 <= 0; valid15_ff2 <= 0;
        valid4_ff3 <= 0;  valid5_ff3 <= 0;   valid6_ff3 <= 0;  valid7_ff3 <= 0;  valid8_ff3 <= 0;  valid9_ff3 <= 0;  valid10_ff3 <= 0; valid11_ff3 <= 0; valid12_ff3 <= 0; valid13_ff3 <= 0; valid14_ff3 <= 0; valid15_ff3 <= 0;
        valid5_ff4 <= 0;  valid6_ff4 <= 0;   valid7_ff4 <= 0;  valid8_ff4 <= 0;  valid9_ff4 <= 0;  valid10_ff4 <= 0; valid11_ff4 <= 0; valid12_ff4 <= 0; valid13_ff4 <= 0; valid14_ff4 <= 0; valid15_ff4 <= 0;
        valid6_ff5 <= 0;  valid7_ff5 <= 0;   valid8_ff5 <= 0;  valid9_ff5 <= 0;  valid10_ff5 <= 0; valid11_ff5 <= 0; valid12_ff5 <= 0; valid13_ff5 <= 0; valid14_ff5 <= 0; valid15_ff5 <= 0;
        valid7_ff6 <= 0;  valid8_ff6 <= 0;   valid9_ff6 <= 0;  valid10_ff6 <= 0; valid11_ff6 <= 0; valid12_ff6 <= 0; valid13_ff6 <= 0; valid14_ff6 <= 0; valid15_ff6 <= 0;
        valid8_ff7 <= 0;  valid9_ff7 <= 0;   valid10_ff7 <= 0; valid11_ff7 <= 0; valid12_ff7 <= 0; valid13_ff7 <= 0; valid14_ff7 <= 0; valid15_ff7 <= 0;
        valid9_ff8 <= 0;  valid10_ff8 <= 0;  valid11_ff8 <= 0; valid12_ff8 <= 0; valid13_ff8 <= 0; valid14_ff8 <= 0; valid15_ff8 <= 0;
        valid10_ff9 <= 0; valid11_ff9 <= 0;  valid12_ff9 <= 0; valid13_ff9 <= 0; valid14_ff9 <= 0; valid15_ff9 <= 0;
        valid11_ff10<= 0; valid12_ff10<= 0;  valid13_ff10<= 0; valid14_ff10<= 0; valid15_ff10<= 0;
        valid12_ff11<= 0; valid13_ff11<= 0;  valid14_ff11<= 0; valid15_ff11<= 0;
        valid13_ff12<= 0; valid14_ff12<= 0; valid15_ff12<= 0;
        valid14_ff13<= 0; valid15_ff13<= 0;
        valid15_ff14<= 0;
    end
    else begin
        valid1_ff0 <= valid1;       valid2_ff0 <= valid2;       valid3_ff0 <= valid3;       valid4_ff0 <= valid4;       valid5_ff0 <= valid5;       valid6_ff0 <= valid6;       valid7_ff0 <= valid7;       valid8_ff0 <= valid8;       valid9_ff0 <= valid9;       valid10_ff0 <= valid10;     valid11_ff0 <= valid11;     valid12_ff0 <= valid12;     valid13_ff0 <= valid13;     valid14_ff0 <= valid14;     valid15_ff0 <= valid15;
        valid2_ff1 <= valid2_ff0;   valid3_ff1 <= valid3_ff0;   valid4_ff1 <= valid4_ff0;   valid5_ff1 <= valid5_ff0;   valid6_ff1 <= valid6_ff0;   valid7_ff1 <= valid7_ff0;   valid8_ff1 <= valid8_ff0;   valid9_ff1 <= valid9_ff0;   valid10_ff1 <= valid10_ff0; valid11_ff1 <= valid11_ff0; valid12_ff1 <= valid12_ff0; valid13_ff1 <= valid13_ff0; valid14_ff1 <= valid14_ff0; valid15_ff1 <= valid15_ff0;
        valid3_ff2 <= valid3_ff1;   valid4_ff2 <= valid4_ff1;   valid5_ff2 <= valid5_ff1;   valid6_ff2 <= valid6_ff1;   valid7_ff2 <= valid7_ff1;   valid8_ff2 <= valid8_ff1;   valid9_ff2 <= valid9_ff1;   valid10_ff2 <= valid10_ff1; valid11_ff2 <= valid11_ff1; valid12_ff2 <= valid12_ff1; valid13_ff2 <= valid13_ff1; valid14_ff2 <= valid14_ff1; valid15_ff2 <= valid15_ff1;
        valid4_ff3 <= valid4_ff2;   valid5_ff3 <= valid5_ff2;   valid6_ff3 <= valid6_ff2;   valid7_ff3 <= valid7_ff2;   valid8_ff3 <= valid8_ff2;   valid9_ff3 <= valid9_ff2;   valid10_ff3 <= valid10_ff2; valid11_ff3 <= valid11_ff2; valid12_ff3 <= valid12_ff2; valid13_ff3 <= valid13_ff2; valid14_ff3 <= valid14_ff2; valid15_ff3 <= valid15_ff2;
        valid5_ff4 <= valid5_ff3;   valid6_ff4 <= valid6_ff3;   valid7_ff4 <= valid7_ff3;   valid8_ff4 <= valid8_ff3;   valid9_ff4 <= valid9_ff3;   valid10_ff4 <= valid10_ff3; valid11_ff4 <= valid11_ff3; valid12_ff4 <= valid12_ff3; valid13_ff4 <= valid13_ff3; valid14_ff4 <= valid14_ff3; valid15_ff4 <= valid15_ff3;
        valid6_ff5 <= valid6_ff4;   valid7_ff5 <= valid7_ff4;   valid8_ff5 <= valid8_ff4;   valid9_ff5 <= valid9_ff4;   valid10_ff5 <= valid10_ff4; valid11_ff5 <= valid11_ff4; valid12_ff5 <= valid12_ff4; valid13_ff5 <= valid13_ff4; valid14_ff5 <= valid14_ff4; valid15_ff5 <= valid15_ff4;
        valid7_ff6 <= valid7_ff5;   valid8_ff6 <= valid8_ff5;   valid9_ff6 <= valid9_ff5;   valid10_ff6 <= valid10_ff5; valid11_ff6 <= valid11_ff5; valid12_ff6 <= valid12_ff5; valid13_ff6 <= valid13_ff5; valid14_ff6 <= valid14_ff5; valid15_ff6 <= valid15_ff5;
        valid8_ff7 <= valid8_ff6;   valid9_ff7 <= valid9_ff6;   valid10_ff7 <= valid10_ff6; valid11_ff7 <= valid11_ff6; valid12_ff7 <= valid12_ff6; valid13_ff7 <= valid13_ff6; valid14_ff7 <= valid14_ff6; valid15_ff7 <= valid15_ff6;
        valid9_ff8 <= valid9_ff7;   valid10_ff8 <= valid10_ff7; valid11_ff8 <= valid11_ff7; valid12_ff8 <= valid12_ff7; valid13_ff8 <= valid13_ff7; valid14_ff8 <= valid14_ff7; valid15_ff8 <= valid15_ff7;
        valid10_ff9 <= valid10_ff8; valid11_ff9 <= valid11_ff8; valid12_ff9 <= valid12_ff8; valid13_ff9 <= valid13_ff8; valid14_ff9 <= valid14_ff8; valid15_ff9 <= valid15_ff8;
        valid11_ff10<= valid11_ff9; valid12_ff10<= valid12_ff9; valid13_ff10<= valid13_ff9; valid14_ff10<= valid14_ff9; valid15_ff10<= valid15_ff9;
        valid12_ff11<= valid12_ff10;valid13_ff11<= valid13_ff10;valid14_ff11<= valid14_ff10;valid15_ff11<= valid15_ff10;
        valid13_ff12<= valid13_ff11;valid14_ff12<= valid14_ff11;valid15_ff12<= valid15_ff11;
        valid14_ff13<= valid14_ff12;valid15_ff13<= valid15_ff12;
        valid15_ff14<= valid15_ff13;
    end
end

always @(*) begin
    row0 = grabbing ? A_data_out[127:120] : 0;
    row1 = grabbing ? A_data_out[119:112] : 0;
    row2 = grabbing ? A_data_out[111:104] : 0;
    row3 = grabbing ? A_data_out[103:96] : 0;
    row4 = grabbing ? A_data_out[95:88] : 0;
    row5 = grabbing ? A_data_out[87:80] : 0;
    row6 = grabbing ? A_data_out[79:72] : 0;
    row7 = grabbing ? A_data_out[71:64] : 0;
    row8 = grabbing ? A_data_out[63:56] : 0;
    row9 = grabbing ? A_data_out[55:48] : 0;
    row10= grabbing ? A_data_out[47:40] : 0;
    row11= grabbing ? A_data_out[39:32] : 0;
    row12= grabbing ? A_data_out[31:24] : 0;
    row13= grabbing ? A_data_out[23:16] : 0;
    row14= grabbing ? A_data_out[15: 8] : 0;
    row15= grabbing ? A_data_out[ 7: 0] : 0;

    col0 = grabbing ? B_data_out[127:120] : 0;
    col1 = grabbing ? B_data_out[119:112] : 0;
    col2 = grabbing ? B_data_out[111:104] : 0;
    col3 = grabbing ? B_data_out[103:96] : 0;
    col4 = grabbing ? B_data_out[95:88] : 0;
    col5 = grabbing ? B_data_out[87:80] : 0;
    col6 = grabbing ? B_data_out[79:72] : 0;
    col7 = grabbing ? B_data_out[71:64] : 0;
    col8 = grabbing ? B_data_out[63:56] : 0;
    col9 = grabbing ? B_data_out[55:48] : 0;
    col10= grabbing ? B_data_out[47:40] : 0;
    col11= grabbing ? B_data_out[39:32] : 0;
    col12= grabbing ? B_data_out[31:24] : 0;
    col13= grabbing ? B_data_out[23:16] : 0;
    col14= grabbing ? B_data_out[15: 8] : 0;
    col15= grabbing ? B_data_out[ 7: 0] : 0;
end

always @(posedge clk) begin
    if (!rst_n) begin
        row1_ff0 <= 0;  row2_ff0 <= 0;  row3_ff0 <= 0;  row4_ff0 <= 0;  row5_ff0 <= 0;  row6_ff0 <= 0;  row7_ff0 <= 0;  row8_ff0 <= 0;  row9_ff0 <= 0;  row10_ff0 <= 0; row11_ff0 <= 0; row12_ff0 <= 0; row13_ff0 <= 0; row14_ff0 <= 0; row15_ff0 <= 0;
        row2_ff1 <= 0;  row3_ff1 <= 0;  row4_ff1 <= 0;  row5_ff1 <= 0;  row6_ff1 <= 0;  row7_ff1 <= 0;  row8_ff1 <= 0;  row9_ff1 <= 0;  row10_ff1 <= 0; row11_ff1 <= 0; row12_ff1 <= 0; row13_ff1 <= 0; row14_ff1 <= 0; row15_ff1 <= 0;
        row3_ff2 <= 0;  row4_ff2 <= 0;  row5_ff2 <= 0;  row6_ff2 <= 0;  row7_ff2 <= 0;  row8_ff2 <= 0;  row9_ff2 <= 0;  row10_ff2 <= 0; row11_ff2 <= 0; row12_ff2 <= 0; row13_ff2 <= 0; row14_ff2 <= 0; row15_ff2 <= 0;
        row4_ff3 <= 0;  row5_ff3 <= 0;  row6_ff3 <= 0;  row7_ff3 <= 0;  row8_ff3 <= 0;  row9_ff3 <= 0;  row10_ff3 <= 0; row11_ff3 <= 0; row12_ff3 <= 0; row13_ff3 <= 0; row14_ff3 <= 0; row15_ff3 <= 0;
        row5_ff4 <= 0;  row6_ff4 <= 0;  row7_ff4 <= 0;  row8_ff4 <= 0;  row9_ff4 <= 0;  row10_ff4 <= 0; row11_ff4 <= 0; row12_ff4 <= 0; row13_ff4 <= 0; row14_ff4 <= 0; row15_ff4 <= 0;
        row6_ff5 <= 0;  row7_ff5 <= 0;  row8_ff5 <= 0;  row9_ff5 <= 0;  row10_ff5 <= 0; row11_ff5 <= 0; row12_ff5 <= 0; row13_ff5 <= 0; row14_ff5 <= 0; row15_ff5 <= 0;
        row7_ff6 <= 0;  row8_ff6 <= 0;  row9_ff6 <= 0;  row10_ff6 <= 0; row11_ff6 <= 0; row12_ff6 <= 0; row13_ff6 <= 0; row14_ff6 <= 0; row15_ff6 <= 0;
        row8_ff7 <= 0;  row9_ff7 <= 0;  row10_ff7 <= 0; row11_ff7 <= 0; row12_ff7 <= 0; row13_ff7 <= 0; row14_ff7 <= 0; row15_ff7 <= 0;
        row9_ff8 <= 0;  row10_ff8 <= 0; row11_ff8 <= 0; row12_ff8 <= 0; row13_ff8 <= 0; row14_ff8 <= 0; row15_ff8 <= 0;
        row10_ff9 <= 0; row11_ff9 <= 0; row12_ff9 <= 0; row13_ff9 <= 0; row14_ff9 <= 0; row15_ff9 <= 0;
        row11_ff10<= 0; row12_ff10<= 0; row13_ff10<= 0; row14_ff10<= 0; row15_ff10<= 0;
        row12_ff11<= 0; row13_ff11<= 0; row14_ff11<= 0; row15_ff11<= 0;
        row13_ff12<= 0; row14_ff12<= 0; row15_ff12<= 0;
        row14_ff13<= 0; row15_ff13<= 0;
        row15_ff14<= 0;

        col1_ff0 <= 0;  col2_ff0 <= 0;  col3_ff0 <= 0;  col4_ff0 <= 0;  col5_ff0 <= 0;  col6_ff0 <= 0;  col7_ff0 <= 0;  col8_ff0 <= 0;  col9_ff0 <= 0;  col10_ff0 <= 0; col11_ff0 <= 0; col12_ff0 <= 0; col13_ff0 <= 0; col14_ff0 <= 0; col15_ff0 <= 0;
        col2_ff1 <= 0;  col3_ff1 <= 0;  col4_ff1 <= 0;  col5_ff1 <= 0;  col6_ff1 <= 0;  col7_ff1 <= 0;  col8_ff1 <= 0;  col9_ff1 <= 0;  col10_ff1 <= 0; col11_ff1 <= 0; col12_ff1 <= 0; col13_ff1 <= 0; col14_ff1 <= 0; col15_ff1 <= 0;
        col3_ff2 <= 0;  col4_ff2 <= 0;  col5_ff2 <= 0;  col6_ff2 <= 0;  col7_ff2 <= 0;  col8_ff2 <= 0;  col9_ff2 <= 0;  col10_ff2 <= 0; col11_ff2 <= 0; col12_ff2 <= 0; col13_ff2 <= 0; col14_ff2 <= 0; col15_ff2 <= 0;
        col4_ff3 <= 0;  col5_ff3 <= 0;  col6_ff3 <= 0;  col7_ff3 <= 0;  col8_ff3 <= 0;  col9_ff3 <= 0;  col10_ff3 <= 0; col11_ff3 <= 0; col12_ff3 <= 0; col13_ff3 <= 0; col14_ff3 <= 0; col15_ff3 <= 0;
        col5_ff4 <= 0;  col6_ff4 <= 0;  col7_ff4 <= 0;  col8_ff4 <= 0;  col9_ff4 <= 0;  col10_ff4 <= 0; col11_ff4 <= 0; col12_ff4 <= 0; col13_ff4 <= 0; col14_ff4 <= 0; col15_ff4 <= 0;
        col6_ff5 <= 0;  col7_ff5 <= 0;  col8_ff5 <= 0;  col9_ff5 <= 0;  col10_ff5 <= 0; col11_ff5 <= 0; col12_ff5 <= 0; col13_ff5 <= 0; col14_ff5 <= 0; col15_ff5 <= 0;
        col7_ff6 <= 0;  col8_ff6 <= 0;  col9_ff6 <= 0;  col10_ff6 <= 0; col11_ff6 <= 0; col12_ff6 <= 0; col13_ff6 <= 0; col14_ff6 <= 0; col15_ff6 <= 0;
        col8_ff7 <= 0;  col9_ff7 <= 0;  col10_ff7 <= 0; col11_ff7 <= 0; col12_ff7 <= 0; col13_ff7 <= 0; col14_ff7 <= 0; col15_ff7 <= 0;
        col9_ff8 <= 0;  col10_ff8 <= 0; col11_ff8 <= 0; col12_ff8 <= 0; col13_ff8 <= 0; col14_ff8 <= 0; col15_ff8 <= 0;
        col10_ff9 <= 0; col11_ff9 <= 0; col12_ff9 <= 0; col13_ff9 <= 0; col14_ff9 <= 0; col15_ff9 <= 0;
        col11_ff10<= 0; col12_ff10<= 0; col13_ff10<= 0; col14_ff10<= 0; col15_ff10<= 0;
        col12_ff11<= 0; col13_ff11<= 0; col14_ff11<= 0; col15_ff11<= 0;
        col13_ff12<= 0; col14_ff12<= 0; col15_ff12<= 0;
        col14_ff13<= 0; col15_ff13<= 0;
        col15_ff14<= 0;
    end
    else begin
        row1_ff0 <= row1;       row2_ff0 <= row2;       row3_ff0 <= row3;       row4_ff0 <= row4;       row5_ff0 <= row5;       row6_ff0 <= row6;       row7_ff0 <= row7;       row8_ff0 <= row8;       row9_ff0 <= row9;       row10_ff0 <= row10;     row11_ff0 <= row11;     row12_ff0 <= row12;     row13_ff0 <= row13;     row14_ff0 <= row14;     row15_ff0 <= row15;
        row2_ff1 <= row2_ff0;   row3_ff1 <= row3_ff0;   row4_ff1 <= row4_ff0;   row5_ff1 <= row5_ff0;   row6_ff1 <= row6_ff0;   row7_ff1 <= row7_ff0;   row8_ff1 <= row8_ff0;   row9_ff1 <= row9_ff0;   row10_ff1 <= row10_ff0; row11_ff1 <= row11_ff0; row12_ff1 <= row12_ff0; row13_ff1 <= row13_ff0; row14_ff1 <= row14_ff0; row15_ff1 <= row15_ff0;
        row3_ff2 <= row3_ff1;   row4_ff2 <= row4_ff1;   row5_ff2 <= row5_ff1;   row6_ff2 <= row6_ff1;   row7_ff2 <= row7_ff1;   row8_ff2 <= row8_ff1;   row9_ff2 <= row9_ff1;   row10_ff2 <= row10_ff1; row11_ff2 <= row11_ff1; row12_ff2 <= row12_ff1; row13_ff2 <= row13_ff1; row14_ff2 <= row14_ff1; row15_ff2 <= row15_ff1;
        row4_ff3 <= row4_ff2;   row5_ff3 <= row5_ff2;   row6_ff3 <= row6_ff2;   row7_ff3 <= row7_ff2;   row8_ff3 <= row8_ff2;   row9_ff3 <= row9_ff2;   row10_ff3 <= row10_ff2; row11_ff3 <= row11_ff2; row12_ff3 <= row12_ff2; row13_ff3 <= row13_ff2; row14_ff3 <= row14_ff2; row15_ff3 <= row15_ff2;
        row5_ff4 <= row5_ff3;   row6_ff4 <= row6_ff3;   row7_ff4 <= row7_ff3;   row8_ff4 <= row8_ff3;   row9_ff4 <= row9_ff3;   row10_ff4 <= row10_ff3; row11_ff4 <= row11_ff3; row12_ff4 <= row12_ff3; row13_ff4 <= row13_ff3; row14_ff4 <= row14_ff3; row15_ff4 <= row15_ff3;
        row6_ff5 <= row6_ff4;   row7_ff5 <= row7_ff4;   row8_ff5 <= row8_ff4;   row9_ff5 <= row9_ff4;   row10_ff5 <= row10_ff4; row11_ff5 <= row11_ff4; row12_ff5 <= row12_ff4; row13_ff5 <= row13_ff4; row14_ff5 <= row14_ff4; row15_ff5 <= row15_ff4;
        row7_ff6 <= row7_ff5;   row8_ff6 <= row8_ff5;   row9_ff6 <= row9_ff5;   row10_ff6 <= row10_ff5; row11_ff6 <= row11_ff5; row12_ff6 <= row12_ff5; row13_ff6 <= row13_ff5; row14_ff6 <= row14_ff5; row15_ff6 <= row15_ff5;
        row8_ff7 <= row8_ff6;   row9_ff7 <= row9_ff6;   row10_ff7 <= row10_ff6; row11_ff7 <= row11_ff6; row12_ff7 <= row12_ff6; row13_ff7 <= row13_ff6; row14_ff7 <= row14_ff6; row15_ff7 <= row15_ff6;
        row9_ff8 <= row9_ff7;   row10_ff8 <= row10_ff7; row11_ff8 <= row11_ff7; row12_ff8 <= row12_ff7; row13_ff8 <= row13_ff7; row14_ff8 <= row14_ff7; row15_ff8 <= row15_ff7;
        row10_ff9 <= row10_ff8; row11_ff9 <= row11_ff8; row12_ff9 <= row12_ff8; row13_ff9 <= row13_ff8; row14_ff9 <= row14_ff8; row15_ff9 <= row15_ff8;
        row11_ff10<= row11_ff9; row12_ff10<= row12_ff9; row13_ff10<= row13_ff9; row14_ff10<= row14_ff9; row15_ff10<= row15_ff9;
        row12_ff11<= row12_ff10;row13_ff11<= row13_ff10;row14_ff11<= row14_ff10;row15_ff11<= row15_ff10;
        row13_ff12<= row13_ff11;row14_ff12<= row14_ff11;row15_ff12<= row15_ff11;
        row14_ff13<= row14_ff12;row15_ff13<= row15_ff12;
        row15_ff14<= row15_ff13;

        col1_ff0 <= col1;       col2_ff0 <= col2;       col3_ff0 <= col3;       col4_ff0 <= col4;       col5_ff0 <= col5;       col6_ff0 <= col6;       col7_ff0 <= col7;       col8_ff0 <= col8;       col9_ff0 <= col9;       col10_ff0 <= col10;     col11_ff0 <= col11;     col12_ff0 <= col12;     col13_ff0 <= col13;     col14_ff0 <= col14;     col15_ff0 <= col15;
        col2_ff1 <= col2_ff0;   col3_ff1 <= col3_ff0;   col4_ff1 <= col4_ff0;   col5_ff1 <= col5_ff0;   col6_ff1 <= col6_ff0;   col7_ff1 <= col7_ff0;   col8_ff1 <= col8_ff0;   col9_ff1 <= col9_ff0;   col10_ff1 <= col10_ff0; col11_ff1 <= col11_ff0; col12_ff1 <= col12_ff0; col13_ff1 <= col13_ff0; col14_ff1 <= col14_ff0; col15_ff1 <= col15_ff0;
        col3_ff2 <= col3_ff1;   col4_ff2 <= col4_ff1;   col5_ff2 <= col5_ff1;   col6_ff2 <= col6_ff1;   col7_ff2 <= col7_ff1;   col8_ff2 <= col8_ff1;   col9_ff2 <= col9_ff1;   col10_ff2 <= col10_ff1; col11_ff2 <= col11_ff1; col12_ff2 <= col12_ff1; col13_ff2 <= col13_ff1; col14_ff2 <= col14_ff1; col15_ff2 <= col15_ff1;
        col4_ff3 <= col4_ff2;   col5_ff3 <= col5_ff2;   col6_ff3 <= col6_ff2;   col7_ff3 <= col7_ff2;   col8_ff3 <= col8_ff2;   col9_ff3 <= col9_ff2;   col10_ff3 <= col10_ff2; col11_ff3 <= col11_ff2; col12_ff3 <= col12_ff2; col13_ff3 <= col13_ff2; col14_ff3 <= col14_ff2; col15_ff3 <= col15_ff2;
        col5_ff4 <= col5_ff3;   col6_ff4 <= col6_ff3;   col7_ff4 <= col7_ff3;   col8_ff4 <= col8_ff3;   col9_ff4 <= col9_ff3;   col10_ff4 <= col10_ff3; col11_ff4 <= col11_ff3; col12_ff4 <= col12_ff3; col13_ff4 <= col13_ff3; col14_ff4 <= col14_ff3; col15_ff4 <= col15_ff3;
        col6_ff5 <= col6_ff4;   col7_ff5 <= col7_ff4;   col8_ff5 <= col8_ff4;   col9_ff5 <= col9_ff4;   col10_ff5 <= col10_ff4; col11_ff5 <= col11_ff4; col12_ff5 <= col12_ff4; col13_ff5 <= col13_ff4; col14_ff5 <= col14_ff4; col15_ff5 <= col15_ff4;
        col7_ff6 <= col7_ff5;   col8_ff6 <= col8_ff5;   col9_ff6 <= col9_ff5;   col10_ff6 <= col10_ff5; col11_ff6 <= col11_ff5; col12_ff6 <= col12_ff5; col13_ff6 <= col13_ff5; col14_ff6 <= col14_ff5; col15_ff6 <= col15_ff5;
        col8_ff7 <= col8_ff6;   col9_ff7 <= col9_ff6;   col10_ff7 <= col10_ff6; col11_ff7 <= col11_ff6; col12_ff7 <= col12_ff6; col13_ff7 <= col13_ff6; col14_ff7 <= col14_ff6; col15_ff7 <= col15_ff6;
        col9_ff8 <= col9_ff7;   col10_ff8 <= col10_ff7; col11_ff8 <= col11_ff7; col12_ff8 <= col12_ff7; col13_ff8 <= col13_ff7; col14_ff8 <= col14_ff7; col15_ff8 <= col15_ff7;
        col10_ff9 <= col10_ff8; col11_ff9 <= col11_ff8; col12_ff9 <= col12_ff8; col13_ff9 <= col13_ff8; col14_ff9 <= col14_ff8; col15_ff9 <= col15_ff8;
        col11_ff10<= col11_ff9; col12_ff10<= col12_ff9; col13_ff10<= col13_ff9; col14_ff10<= col14_ff9; col15_ff10<= col15_ff9;
        col12_ff11<= col12_ff10;col13_ff11<= col13_ff10;col14_ff11<= col14_ff10;col15_ff11<= col15_ff10;
        col13_ff12<= col13_ff11;col14_ff12<= col14_ff11;col15_ff12<= col15_ff11;
        col14_ff13<= col14_ff12;col15_ff13<= col15_ff12;
        col15_ff14<= col15_ff13;
    end
end

always @(*) begin
    a_bus = {row0, row1_ff0, row2_ff1, row3_ff2, row4_ff3, row5_ff4, row6_ff5, row7_ff6, row8_ff7, row9_ff8, row10_ff9, row11_ff10, row12_ff11, row13_ff12, row14_ff13, row15_ff14};
    b_bus = {col0, col1_ff0, col2_ff1, col3_ff2, col4_ff3, col5_ff4, col6_ff5, col7_ff6, col8_ff7, col9_ff8, col10_ff9, col11_ff10, col12_ff11, col13_ff12, col14_ff13, col15_ff14};
    valid_bus = {valid0, valid1_ff0, valid2_ff1, valid3_ff2, valid4_ff3, valid5_ff4, valid6_ff5, valid7_ff6, valid8_ff7, valid9_ff8, valid10_ff9, valid11_ff10, valid12_ff11, valid13_ff12, valid14_ff13, valid15_ff14};
end

SYS_16x16_ARRAY sys_array ( .clk(clk), .rst_n(rst_n), .in_valid(valid_bus), .offset_valid(1'b1), .sys_rst_seq0(cal_rst), 
                            .left(a_bus), .top(b_bus), .out_valid(out_valid), 
                            .row0_out(result0), .row1_out(result1), .row2_out(result2), .row3_out(result3), 
                            .row4_out(result4), .row5_out(result5), .row6_out(result6), .row7_out(result7), 
                            .row8_out(result8), .row9_out(result9), .row10_out(result10), .row11_out(result11), 
                            .row12_out(result12), .row13_out(result13), .row14_out(result14), .row15_out(result15));

always @(posedge clk) begin
    if (!rst_n) begin
        eq_k_ff0 <= 0;

        r0_done <= 0;
        r1_done <= 0;
        r2_done <= 0;
        r3_done <= 0;
        r4_done <= 0;
        r5_done <= 0;
        r6_done <= 0;
        r7_done <= 0;
        r8_done <= 0;
        r9_done <= 0;
        r10_done <= 0;
        r11_done <= 0;
        r12_done <= 0;
        r13_done <= 0;
        r14_done <= 0;
        r15_done <= 0;
    end
    else begin
        eq_k_ff0 <= state == FEED ? eq_k : 0;

        r0_done <= in_valid ? 0 : eq_k_ff0;
        r1_done <= in_valid ? 0 : r0_done;
        r2_done <= in_valid ? 0 : r1_done;
        r3_done <= in_valid ? 0 : r2_done;
        r4_done <= in_valid ? 0 : r3_done;
        r5_done <= in_valid ? 0 : r4_done;
        r6_done <= in_valid ? 0 : r5_done;
        r7_done <= in_valid ? 0 : r6_done;
        r8_done <= in_valid ? 0 : r7_done;
        r9_done <= in_valid ? 0 : r8_done;
        r10_done <= in_valid ? 0 : r9_done;
        r11_done <= in_valid ? 0 : r10_done;
        r12_done <= in_valid ? 0 : r11_done;
        r13_done <= in_valid ? 0 : r12_done;
        r14_done <= in_valid ? 0 : r13_done;
        r15_done <= in_valid ? 0 : r14_done;
    end
end

always @(posedge clk) begin
    if (!rst_n) idx_c <= 0;
    else begin
        if (in_valid) idx_c <= 0;
        else if (|write_valid) idx_c <= idx_c + 1;
        else idx_c <= idx_c;
    end
end

always @(posedge clk) begin
    if (!rst_n) busy <= 0;
    else busy <= in_valid ? 1 : (end_calculating ? 0 : busy);
end

endmodule
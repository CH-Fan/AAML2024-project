// Copyright 2021 The CFU-Playground Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

`include "global_buffer_bram.v"
`include "TPU.v"

module Cfu (
  input               cmd_valid,
  output reg          cmd_ready,
  input      [9:0]    cmd_payload_function_id,
  input      [31:0]   cmd_payload_inputs_0,
  input      [31:0]   cmd_payload_inputs_1,
  output reg          rsp_valid,
  input               rsp_ready,
  output reg [31:0]   rsp_payload_outputs_0,
  input               reset,
  input               clk
);
  // ==================================================
  // ===================== MODULE =====================
  // ==================================================
  wire A_wr_en, B_wr_en, C_wr_en;
  // wire [12:0] A_index, B_index, C_index;
  wire [13:0] A_index;
  wire [11:0] B_index;
  wire [10:0] C_index;
  wire [127:0] A_data_in, B_data_in;
  wire [127:0] A_data_out, B_data_out;
  wire [511:0] C_data_in;
  wire [511:0] C_data_out;

  wire rst_n = ~reset;
  wire in_valid;
  wire offset_valid;
  wire [9:0] K;
  wire [10:0] M;
  wire [8:0] N;
  wire busy;

  wire Awr_tpu, Bwr_tpu, Cwr_tpu;
  // wire [12:0] Aidx_tpu, Bidx_tpu, Cidx_tpu;
  wire [13:0] Aidx_tpu;
  wire [11:0] Bidx_tpu;
  wire [10:0] Cidx_tpu;
  wire [127:0] Adata_tpu, Bdata_tpu;
  wire [511:0] Cdata_tpu;

  global_buffer_bram #(
    .ADDR_BITS(14),
    .DATA_BITS(128)
  )
  gbuff_A(
    .clk(clk),
    .rst_n(1'b1),
    .ram_en(1'b1),
    .wr_en(A_wr_en),
    .index(A_index),
    .data_in(A_data_in),
    .data_out(A_data_out)
  );

  global_buffer_bram #(
    .ADDR_BITS(12),
    .DATA_BITS(128)
  )
  gbuff_B(
    .clk(clk),
    .rst_n(1'b1),
    .ram_en(1'b1),
    .wr_en(B_wr_en),
    .index(B_index),
    .data_in(B_data_in),
    .data_out(B_data_out)
  );

  global_buffer_bram #(
    .ADDR_BITS(11),
    .DATA_BITS(512)
  )
  gbuff_C(
    .clk(clk),
    .rst_n(1'b1),
    .ram_en(1'b1),
    .wr_en(C_wr_en),
    .index(C_index),
    .data_in(C_data_in),
    .data_out(C_data_out)
  );

  TPU TPU_in_CFU(
    .clk(clk),
    .rst_n(rst_n),

    .in_valid(in_valid),
    .offset_valid(offset_valid),
    .K(K),
    .M(M),
    .N(N),
    .busy(busy),

    .A_wr_en(Awr_tpu),
    .A_index(Aidx_tpu),
    .A_data_in(Adata_tpu),
    .A_data_out(A_data_out),

    .B_wr_en(Bwr_tpu),
    .B_index(Bidx_tpu),
    .B_data_in(Bdata_tpu),
    .B_data_out(B_data_out),

    .C_wr_en(Cwr_tpu),
    .C_index(Cidx_tpu),
    .C_data_in(Cdata_tpu),
    .C_data_out(C_data_out)
  );


  // ==================================================
  // ===================== DESIGN =====================
  // ==================================================
  wire [6:0] func7 = cmd_payload_function_id[9:3];
  wire [2:0] func3 = cmd_payload_function_id[2:0];

  reg tpu_invalid;
  reg tpu_offsetvalid;
  reg [9:0] tpu_K;
  reg [10:0] tpu_M;
  reg [8:0] tpu_N;

  reg [13:0] temp_idx;
  reg [31:0] temp_value0, temp_value1;

  reg Awr_cpu, Bwr_cpu, Cwr_cpu;
  // reg [12:0] Aidx_cpu, Bidx_cpu, Cidx_cpu;
  reg [13:0] Aidx_cpu;
  reg [11:0] Bidx_cpu;
  reg [10:0] Cidx_cpu;
  reg [127:0] Adata_cpu, Bdata_cpu;
  reg [511:0] Cdata_cpu;

  reg Awr, Bwr, Cwr;
  // reg [12:0] Aidx, Bidx, Cidx;
  reg [13:0] Aidx;
  reg [11:0] Bidx;
  reg [10:0] Cidx;
  reg [127:0] Adata, Bdata;
  reg [511:0] Cdata;

  parameter IDLE  = 0;
  parameter READ  = 1;
  parameter WRITE = 2;
  parameter MULT  = 3;
  parameter OUTT  = 4;
  parameter DONE  = 5;
  // parameter TEMP  = 6;

  reg [2:0] state, state_nxt;

  // func3: 0 => Multiplication
  // func3: 1 => Write (CPU  -> BRAM)
  // func3: 2 => Read  (BRAM -> CPU)
  // func3: 3 => Temporary Register for index and value
  always @(*) begin
    case (state)
    IDLE: begin
      if (cmd_valid) begin
        case (func3[1:0])
        2'b00:  state_nxt = MULT;
        2'b01:  state_nxt = WRITE;
        2'b10:  state_nxt = READ;
        2'b11:  state_nxt = DONE;
        endcase
      end
      else state_nxt = IDLE;
    end
    READ: state_nxt = OUTT;
    WRITE:state_nxt = DONE;
    MULT: state_nxt = busy ? MULT : DONE;
    OUTT: state_nxt = IDLE;
    DONE: state_nxt = IDLE;
    // TEMP: state_nxt = IDLE;
    default:  state_nxt = IDLE;
    endcase
  end

  always @(posedge clk) begin
    if (reset) state <= IDLE;
    else state <= state_nxt;
  end

  reg [31:0] i0, i1;
  always @(posedge clk) begin
    if (reset) begin
      i1 <= 0;
    end
    else begin
      if (cmd_valid) i1 <= cmd_payload_inputs_1;
      else i1 <= i1;
    end
  end

  // Matrix Multiplication
  always @(*) begin
    tpu_invalid = state == IDLE && state_nxt == MULT ? 'b1 : 'b0;
    tpu_offsetvalid = state == IDLE && state_nxt == MULT ? func7[0] : tpu_offsetvalid;
    tpu_K = state == IDLE && state_nxt == MULT ? cmd_payload_inputs_0[9:0] : 0;
    tpu_M = state == IDLE && state_nxt == MULT ? cmd_payload_inputs_1[26:16] : 0;
    tpu_N = state == IDLE && state_nxt == MULT ? cmd_payload_inputs_1[8:0] : 0;
  end
  assign in_valid = tpu_invalid;
  assign offset_valid = tpu_offsetvalid;
  assign K = tpu_K;
  assign M = tpu_M;
  assign N = tpu_N;

  // Temporary Register
  always @(posedge clk) begin
    if (reset) begin
      temp_idx <= 0;
      temp_value0 <= 0;
      temp_value1 <= 0;
    end
    else begin
      if (state == IDLE && state_nxt == DONE) begin
        if (func7[0]) begin
          temp_idx <= cmd_payload_inputs_0[13:0];
          temp_value0 <= temp_value0;
          temp_value1 <= temp_value1;
        end
        else begin
          temp_idx <= temp_idx;
          temp_value0 <= cmd_payload_inputs_0;
          temp_value1 <= cmd_payload_inputs_1;
        end
      end
      else begin
        temp_idx <= temp_idx;
        temp_value0 <= temp_value0;
        temp_value1 <= temp_value1;
      end
    end
  end

  // Write Buffer A & Buffer B from CPU
  always @(posedge clk) begin
    if (reset) begin
        Awr_cpu <= 'b0;
        Aidx_cpu <= 14'b11_1111_1111_1111;
        Adata_cpu <= 0;

        Bwr_cpu <= 'b0;
        Bidx_cpu <= 12'b1111_1111_1111;
        Bdata_cpu <= 0;
    end
    else begin
      if (state == IDLE && state_nxt == WRITE) begin
        Awr_cpu <= |func7 ? 'b0 : 'b1;
        Aidx_cpu <= |func7 ? 0 : temp_idx;//Aidx_cpu : Aidx_cpu + 1;
        Adata_cpu <= |func7 ? 0 : {temp_value0, temp_value1, cmd_payload_inputs_0, cmd_payload_inputs_1};

        Bwr_cpu <= |func7 ? 'b1 : 'b0;
        Bidx_cpu <= |func7 ? temp_idx : 0;//Bidx_cpu + 1 : Bidx_cpu;
        Bdata_cpu <= |func7 ? {temp_value0, temp_value1, cmd_payload_inputs_0, cmd_payload_inputs_1} : 0;
      end
      // else if (state == IDLE && state_nxt == MULT) begin
      //   Awr_cpu <= 'b0;
      //   Aidx_cpu <= 14'b11_1111_1111_1111;
      //   Adata_cpu <= 0;

      //   Bwr_cpu <= 'b0;
      //   Bidx_cpu <= 12'b1111_1111_1111;
      //   Bdata_cpu <= 0;
      // end
      else begin
        Awr_cpu <= 'b0;
        Aidx_cpu <= Aidx_cpu;
        Adata_cpu <= 0;

        Bwr_cpu <= 'b0;
        Bidx_cpu <= Bidx_cpu;
        Bdata_cpu <= 0;
      end
    end
  end

  // Read Buffer C from CPU
  always @(posedge clk) begin
    if (reset) begin
      Cwr_cpu <= 'b0;
      Cidx_cpu <= 0;
      Cdata_cpu <= 0;
    end
    else begin
      if (state == IDLE && state_nxt == READ) begin
        Cwr_cpu <= 'b0;
        Cidx_cpu <= cmd_payload_inputs_0[10:0];
        Cdata_cpu <= 0;
      end
      else begin
        Cwr_cpu <= 'b0;
        Cidx_cpu <= 0;
        Cdata_cpu <= 0;
      end
    end
  end

  // CFU IO
  always @(*) begin
    cmd_ready = state == IDLE ? 'b1 : 'b0;
    rsp_valid = state == OUTT || state == DONE ? 'b1 : 'b0;
  end

  always @(posedge clk) begin
    if (reset) rsp_payload_outputs_0 <= 0;
    else begin
      if (state_nxt == OUTT) begin
        case (i1)
        'd0:  rsp_payload_outputs_0 <= C_data_out[511:480];
        'd1:  rsp_payload_outputs_0 <= C_data_out[479:448];
        'd2:  rsp_payload_outputs_0 <= C_data_out[447:416];
        'd3:  rsp_payload_outputs_0 <= C_data_out[415:384];
        'd4:  rsp_payload_outputs_0 <= C_data_out[383:352];
        'd5:  rsp_payload_outputs_0 <= C_data_out[351:320];
        'd6:  rsp_payload_outputs_0 <= C_data_out[319:288];
        'd7:  rsp_payload_outputs_0 <= C_data_out[287:256];
        'd8:  rsp_payload_outputs_0 <= C_data_out[255:224];
        'd9:  rsp_payload_outputs_0 <= C_data_out[223:192];
        'd10:  rsp_payload_outputs_0 <= C_data_out[191:160];
        'd11:  rsp_payload_outputs_0 <= C_data_out[159:128];
        'd12:  rsp_payload_outputs_0 <= C_data_out[127:96];
        'd13:  rsp_payload_outputs_0 <= C_data_out[95:64];
        'd14: rsp_payload_outputs_0 <= C_data_out[63:32];
        'd15: rsp_payload_outputs_0 <= C_data_out[31:0];
        default:rsp_payload_outputs_0 <= 1;
        endcase
      end
      else if (state_nxt == DONE) rsp_payload_outputs_0 <= ~32'd0;
      else rsp_payload_outputs_0 <= 0;
    end
  end

  // Interface
  always @(*) begin
    if (state == MULT) begin
      Awr = Awr_tpu;
      Bwr = Bwr_tpu;
      Cwr = Cwr_tpu;

      Aidx = Aidx_tpu;
      Bidx = Bidx_tpu;
      Cidx = Cidx_tpu;

      Adata = Adata_tpu;
      Bdata = Bdata_tpu;
      Cdata = Cdata_tpu;
    end
    else begin
      Awr = Awr_cpu;
      Bwr = Bwr_cpu;
      Cwr = Cwr_cpu;

      Aidx = Aidx_cpu;
      Bidx = Bidx_cpu;
      Cidx = Cidx_cpu;

      Adata = Adata_cpu;
      Bdata = Bdata_cpu;
      Cdata = Cdata_cpu;
    end
    // else begin
    //   Awr = 'b0;
    //   Bwr = 'b0;
    //   Cwr = 'b0;

    //   Aidx = 0;
    //   Bidx = 0;
    //   Cidx = 0;

    //   Adata = 0;
    //   Bdata = 0;
    //   Cdata = 0;
    // end
  end
  assign A_wr_en = Awr;
  assign B_wr_en = Bwr;
  assign C_wr_en = Cwr;
  assign A_index = Aidx;
  assign B_index = Bidx;
  assign C_index = Cidx;
  assign A_data_in = Adata;
  assign B_data_in = Bdata;
  assign C_data_in = Cdata;


endmodule

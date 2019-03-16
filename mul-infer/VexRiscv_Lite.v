// Generator : SpinalHDL v1.3.2    git head : 41815ceafff4e72c2e3a3e1ff7e9ada5202a0d26
// Date      : 16/03/2019, 08:56:56
// Component : VexRiscv


`define Src2CtrlEnum_defaultEncoding_type [1:0]
`define Src2CtrlEnum_defaultEncoding_RS 2'b00
`define Src2CtrlEnum_defaultEncoding_IMI 2'b01
`define Src2CtrlEnum_defaultEncoding_IMS 2'b10
`define Src2CtrlEnum_defaultEncoding_PC 2'b11

`define EnvCtrlEnum_defaultEncoding_type [1:0]
`define EnvCtrlEnum_defaultEncoding_NONE 2'b00
`define EnvCtrlEnum_defaultEncoding_XRET 2'b01
`define EnvCtrlEnum_defaultEncoding_ECALL 2'b10
`define EnvCtrlEnum_defaultEncoding_EBREAK 2'b11

`define Src1CtrlEnum_defaultEncoding_type [1:0]
`define Src1CtrlEnum_defaultEncoding_RS 2'b00
`define Src1CtrlEnum_defaultEncoding_IMU 2'b01
`define Src1CtrlEnum_defaultEncoding_PC_INCREMENT 2'b10
`define Src1CtrlEnum_defaultEncoding_URS1 2'b11

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR_1 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR_1 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND_1 2'b10
`define AluBitwiseCtrlEnum_defaultEncoding_SRC1 2'b11

`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE_1 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL_1 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL_1 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA_1 2'b11

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

module InstructionCache (
      input   io_flush_cmd_valid,
      output  io_flush_cmd_ready,
      output  io_flush_rsp,
      input   io_cpu_prefetch_isValid,
      output reg  io_cpu_prefetch_haltIt,
      input  [31:0] io_cpu_prefetch_pc,
      input   io_cpu_fetch_isValid,
      input   io_cpu_fetch_isStuck,
      input   io_cpu_fetch_isRemoved,
      input  [31:0] io_cpu_fetch_pc,
      output [31:0] io_cpu_fetch_data,
      input   io_cpu_fetch_dataBypassValid,
      input  [31:0] io_cpu_fetch_dataBypass,
      output  io_cpu_fetch_mmuBus_cmd_isValid,
      output [31:0] io_cpu_fetch_mmuBus_cmd_virtualAddress,
      output  io_cpu_fetch_mmuBus_cmd_bypassTranslation,
      input  [31:0] io_cpu_fetch_mmuBus_rsp_physicalAddress,
      input   io_cpu_fetch_mmuBus_rsp_isIoAccess,
      input   io_cpu_fetch_mmuBus_rsp_allowRead,
      input   io_cpu_fetch_mmuBus_rsp_allowWrite,
      input   io_cpu_fetch_mmuBus_rsp_allowExecute,
      input   io_cpu_fetch_mmuBus_rsp_allowUser,
      input   io_cpu_fetch_mmuBus_rsp_miss,
      input   io_cpu_fetch_mmuBus_rsp_hit,
      output  io_cpu_fetch_mmuBus_end,
      output [31:0] io_cpu_fetch_physicalAddress,
      input   io_cpu_decode_isValid,
      input   io_cpu_decode_isStuck,
      input  [31:0] io_cpu_decode_pc,
      output [31:0] io_cpu_decode_physicalAddress,
      output [31:0] io_cpu_decode_data,
      output  io_cpu_decode_cacheMiss,
      output  io_cpu_decode_error,
      output  io_cpu_decode_mmuMiss,
      output  io_cpu_decode_illegalAccess,
      input   io_cpu_decode_isUser,
      input   io_cpu_fill_valid,
      input  [31:0] io_cpu_fill_payload,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [2:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload_data,
      input   io_mem_rsp_payload_error,
      input   clk,
      input   reset);
  reg [22:0] _zz_12_;
  reg [31:0] _zz_13_;
  wire  _zz_14_;
  wire [0:0] _zz_15_;
  wire [0:0] _zz_16_;
  wire [22:0] _zz_17_;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  lineLoader_fire;
  reg  lineLoader_valid;
  reg [31:0] lineLoader_address;
  reg  lineLoader_hadError;
  reg [6:0] lineLoader_flushCounter;
  reg  _zz_3_;
  reg  lineLoader_flushFromInterface;
  wire  _zz_4_;
  reg  _zz_4__regNext;
  reg  lineLoader_cmdSent;
  reg  lineLoader_wayToAllocate_willIncrement;
  wire  lineLoader_wayToAllocate_willClear;
  wire  lineLoader_wayToAllocate_willOverflowIfInc;
  wire  lineLoader_wayToAllocate_willOverflow;
  reg [2:0] lineLoader_wordIndex;
  wire  lineLoader_write_tag_0_valid;
  wire [5:0] lineLoader_write_tag_0_payload_address;
  wire  lineLoader_write_tag_0_payload_data_valid;
  wire  lineLoader_write_tag_0_payload_data_error;
  wire [20:0] lineLoader_write_tag_0_payload_data_address;
  wire  lineLoader_write_data_0_valid;
  wire [8:0] lineLoader_write_data_0_payload_address;
  wire [31:0] lineLoader_write_data_0_payload_data;
  wire  _zz_5_;
  wire [5:0] _zz_6_;
  wire  _zz_7_;
  wire  fetchStage_read_waysValues_0_tag_valid;
  wire  fetchStage_read_waysValues_0_tag_error;
  wire [20:0] fetchStage_read_waysValues_0_tag_address;
  wire [22:0] _zz_8_;
  wire [8:0] _zz_9_;
  wire  _zz_10_;
  wire [31:0] fetchStage_read_waysValues_0_data;
  reg [31:0] decodeStage_mmuRsp_physicalAddress;
  reg  decodeStage_mmuRsp_isIoAccess;
  reg  decodeStage_mmuRsp_allowRead;
  reg  decodeStage_mmuRsp_allowWrite;
  reg  decodeStage_mmuRsp_allowExecute;
  reg  decodeStage_mmuRsp_allowUser;
  reg  decodeStage_mmuRsp_miss;
  reg  decodeStage_mmuRsp_hit;
  reg  decodeStage_hit_tags_0_valid;
  reg  decodeStage_hit_tags_0_error;
  reg [20:0] decodeStage_hit_tags_0_address;
  wire  decodeStage_hit_hits_0;
  wire  decodeStage_hit_valid;
  wire  decodeStage_hit_error;
  reg [31:0] _zz_11_;
  wire [31:0] decodeStage_hit_data;
  reg [31:0] decodeStage_hit_word;
  reg  io_cpu_fetch_dataBypassValid_regNextWhen;
  reg [31:0] io_cpu_fetch_dataBypass_regNextWhen;
  reg [22:0] ways_0_tags [0:63];
  reg [31:0] ways_0_datas [0:511];
  assign _zz_14_ = (! lineLoader_flushCounter[6]);
  assign _zz_15_ = _zz_8_[0 : 0];
  assign _zz_16_ = _zz_8_[1 : 1];
  assign _zz_17_ = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @ (posedge clk) begin
    if(_zz_2_) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_17_;
    end
  end

  always @ (posedge clk) begin
    if(_zz_7_) begin
      _zz_12_ <= ways_0_tags[_zz_6_];
    end
  end

  always @ (posedge clk) begin
    if(_zz_1_) begin
      ways_0_datas[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_10_) begin
      _zz_13_ <= ways_0_datas[_zz_9_];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(lineLoader_write_data_0_valid)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    if(lineLoader_write_tag_0_valid)begin
      _zz_2_ = 1'b1;
    end
  end

  always @ (*) begin
    io_cpu_prefetch_haltIt = 1'b0;
    if(lineLoader_valid)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(_zz_14_)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if((! _zz_3_))begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(io_flush_cmd_valid)begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
  end

  always @ (*) begin
    lineLoader_fire = 1'b0;
    if(io_mem_rsp_valid)begin
      if((lineLoader_wordIndex == (3'b111)))begin
        lineLoader_fire = 1'b1;
      end
    end
  end

  assign io_flush_cmd_ready = (! (lineLoader_valid || io_cpu_fetch_isValid));
  assign _zz_4_ = lineLoader_flushCounter[6];
  assign io_flush_rsp = ((_zz_4_ && (! _zz_4__regNext)) && lineLoader_flushFromInterface);
  assign io_mem_cmd_valid = (lineLoader_valid && (! lineLoader_cmdSent));
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],(5'b00000)};
  assign io_mem_cmd_payload_size = (3'b101);
  always @ (*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0;
    if(lineLoader_fire)begin
      lineLoader_wayToAllocate_willIncrement = 1'b1;
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0;
  assign lineLoader_wayToAllocate_willOverflowIfInc = 1'b1;
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement);
  assign _zz_5_ = 1'b1;
  assign lineLoader_write_tag_0_valid = ((_zz_5_ && lineLoader_fire) || (! lineLoader_flushCounter[6]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[6] ? lineLoader_address[10 : 5] : lineLoader_flushCounter[5 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[6];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 11];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && _zz_5_);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[10 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign _zz_6_ = io_cpu_prefetch_pc[10 : 5];
  assign _zz_7_ = (! io_cpu_fetch_isStuck);
  assign _zz_8_ = _zz_12_;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_15_[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_16_[0];
  assign fetchStage_read_waysValues_0_tag_address = _zz_8_[22 : 2];
  assign _zz_9_ = io_cpu_prefetch_pc[10 : 2];
  assign _zz_10_ = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_waysValues_0_data = _zz_13_;
  assign io_cpu_fetch_data = (io_cpu_fetch_dataBypassValid ? io_cpu_fetch_dataBypass : fetchStage_read_waysValues_0_data[31 : 0]);
  assign io_cpu_fetch_mmuBus_cmd_isValid = io_cpu_fetch_isValid;
  assign io_cpu_fetch_mmuBus_cmd_virtualAddress = io_cpu_fetch_pc;
  assign io_cpu_fetch_mmuBus_cmd_bypassTranslation = 1'b0;
  assign io_cpu_fetch_mmuBus_end = ((! io_cpu_fetch_isStuck) || io_cpu_fetch_isRemoved);
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuBus_rsp_physicalAddress;
  assign decodeStage_hit_hits_0 = (decodeStage_hit_tags_0_valid && (decodeStage_hit_tags_0_address == decodeStage_mmuRsp_physicalAddress[31 : 11]));
  assign decodeStage_hit_valid = (decodeStage_hit_hits_0 != (1'b0));
  assign decodeStage_hit_error = decodeStage_hit_tags_0_error;
  assign decodeStage_hit_data = _zz_11_;
  always @ (*) begin
    decodeStage_hit_word = decodeStage_hit_data[31 : 0];
    if(io_cpu_fetch_dataBypassValid_regNextWhen)begin
      decodeStage_hit_word = io_cpu_fetch_dataBypass_regNextWhen;
    end
  end

  assign io_cpu_decode_data = decodeStage_hit_word;
  assign io_cpu_decode_cacheMiss = (! decodeStage_hit_valid);
  assign io_cpu_decode_error = decodeStage_hit_error;
  assign io_cpu_decode_mmuMiss = decodeStage_mmuRsp_miss;
  assign io_cpu_decode_illegalAccess = ((! decodeStage_mmuRsp_allowExecute) || (io_cpu_decode_isUser && (! decodeStage_mmuRsp_allowUser)));
  assign io_cpu_decode_physicalAddress = decodeStage_mmuRsp_physicalAddress;
  always @ (posedge clk) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushCounter <= (7'b0000000);
      lineLoader_flushFromInterface <= 1'b0;
      lineLoader_cmdSent <= 1'b0;
      lineLoader_wordIndex <= (3'b000);
    end else begin
      if(lineLoader_fire)begin
        lineLoader_valid <= 1'b0;
      end
      if(lineLoader_fire)begin
        lineLoader_hadError <= 1'b0;
      end
      if(io_cpu_fill_valid)begin
        lineLoader_valid <= 1'b1;
      end
      if(_zz_14_)begin
        lineLoader_flushCounter <= (lineLoader_flushCounter + (7'b0000001));
      end
      if(io_flush_cmd_valid)begin
        if(io_flush_cmd_ready)begin
          lineLoader_flushCounter <= (7'b0000000);
          lineLoader_flushFromInterface <= 1'b1;
        end
      end
      if((io_mem_cmd_valid && io_mem_cmd_ready))begin
        lineLoader_cmdSent <= 1'b1;
      end
      if(lineLoader_fire)begin
        lineLoader_cmdSent <= 1'b0;
      end
      if(io_mem_rsp_valid)begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + (3'b001));
        if(io_mem_rsp_payload_error)begin
          lineLoader_hadError <= 1'b1;
        end
      end
    end
  end

  always @ (posedge clk) begin
    if(io_cpu_fill_valid)begin
      lineLoader_address <= io_cpu_fill_payload;
    end
    _zz_3_ <= lineLoader_flushCounter[6];
    _zz_4__regNext <= _zz_4_;
    if((! io_cpu_decode_isStuck))begin
      decodeStage_mmuRsp_physicalAddress <= io_cpu_fetch_mmuBus_rsp_physicalAddress;
      decodeStage_mmuRsp_isIoAccess <= io_cpu_fetch_mmuBus_rsp_isIoAccess;
      decodeStage_mmuRsp_allowRead <= io_cpu_fetch_mmuBus_rsp_allowRead;
      decodeStage_mmuRsp_allowWrite <= io_cpu_fetch_mmuBus_rsp_allowWrite;
      decodeStage_mmuRsp_allowExecute <= io_cpu_fetch_mmuBus_rsp_allowExecute;
      decodeStage_mmuRsp_allowUser <= io_cpu_fetch_mmuBus_rsp_allowUser;
      decodeStage_mmuRsp_miss <= io_cpu_fetch_mmuBus_rsp_miss;
      decodeStage_mmuRsp_hit <= io_cpu_fetch_mmuBus_rsp_hit;
    end
    if((! io_cpu_decode_isStuck))begin
      decodeStage_hit_tags_0_valid <= fetchStage_read_waysValues_0_tag_valid;
      decodeStage_hit_tags_0_error <= fetchStage_read_waysValues_0_tag_error;
      decodeStage_hit_tags_0_address <= fetchStage_read_waysValues_0_tag_address;
    end
    if((! io_cpu_decode_isStuck))begin
      _zz_11_ <= fetchStage_read_waysValues_0_data;
    end
    if((! io_cpu_decode_isStuck))begin
      io_cpu_fetch_dataBypassValid_regNextWhen <= io_cpu_fetch_dataBypassValid;
    end
  end

  always @ (posedge clk) begin
    if((! io_cpu_decode_isStuck))begin
      io_cpu_fetch_dataBypass_regNextWhen <= io_cpu_fetch_dataBypass;
    end
  end

endmodule

module VexRiscv (
      input  [31:0] externalResetVector,
      input   timerInterrupt,
      input  [31:0] externalInterruptArray,
      output reg  iBusWishbone_CYC,
      output reg  iBusWishbone_STB,
      input   iBusWishbone_ACK,
      output  iBusWishbone_WE,
      output [29:0] iBusWishbone_ADR,
      input  [31:0] iBusWishbone_DAT_MISO,
      output [31:0] iBusWishbone_DAT_MOSI,
      output [3:0] iBusWishbone_SEL,
      input   iBusWishbone_ERR,
      output [1:0] iBusWishbone_BTE,
      output [2:0] iBusWishbone_CTI,
      output  dBusWishbone_CYC,
      output  dBusWishbone_STB,
      input   dBusWishbone_ACK,
      output  dBusWishbone_WE,
      output [29:0] dBusWishbone_ADR,
      input  [31:0] dBusWishbone_DAT_MISO,
      output [31:0] dBusWishbone_DAT_MOSI,
      output reg [3:0] dBusWishbone_SEL,
      input   dBusWishbone_ERR,
      output [1:0] dBusWishbone_BTE,
      output [2:0] dBusWishbone_CTI,
      input   clk,
      input   reset);
  reg  _zz_181_;
  wire  _zz_182_;
  wire  _zz_183_;
  wire  _zz_184_;
  wire  _zz_185_;
  wire [31:0] _zz_186_;
  wire  _zz_187_;
  wire  _zz_188_;
  wire  _zz_189_;
  wire  _zz_190_;
  wire  _zz_191_;
  wire  _zz_192_;
  wire  _zz_193_;
  wire  _zz_194_;
  wire  _zz_195_;
  wire  _zz_196_;
  reg [31:0] _zz_197_;
  reg [31:0] _zz_198_;
  reg [31:0] _zz_199_;
  wire  IBusCachedPlugin_cache_io_flush_cmd_ready;
  wire  IBusCachedPlugin_cache_io_flush_rsp;
  wire  IBusCachedPlugin_cache_io_cpu_prefetch_haltIt;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_data;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation;
  wire  IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end;
  wire  IBusCachedPlugin_cache_io_cpu_decode_error;
  wire  IBusCachedPlugin_cache_io_cpu_decode_mmuMiss;
  wire  IBusCachedPlugin_cache_io_cpu_decode_illegalAccess;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_data;
  wire  IBusCachedPlugin_cache_io_cpu_decode_cacheMiss;
  wire [31:0] IBusCachedPlugin_cache_io_cpu_decode_physicalAddress;
  wire  IBusCachedPlugin_cache_io_mem_cmd_valid;
  wire [31:0] IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  wire [2:0] IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  wire  _zz_200_;
  wire  _zz_201_;
  wire  _zz_202_;
  wire  _zz_203_;
  wire  _zz_204_;
  wire  _zz_205_;
  wire  _zz_206_;
  wire [1:0] _zz_207_;
  wire [1:0] _zz_208_;
  wire  _zz_209_;
  wire [1:0] _zz_210_;
  wire [1:0] _zz_211_;
  wire [3:0] _zz_212_;
  wire [2:0] _zz_213_;
  wire [31:0] _zz_214_;
  wire [11:0] _zz_215_;
  wire [31:0] _zz_216_;
  wire [19:0] _zz_217_;
  wire [11:0] _zz_218_;
  wire [2:0] _zz_219_;
  wire [0:0] _zz_220_;
  wire [0:0] _zz_221_;
  wire [0:0] _zz_222_;
  wire [0:0] _zz_223_;
  wire [0:0] _zz_224_;
  wire [0:0] _zz_225_;
  wire [0:0] _zz_226_;
  wire [0:0] _zz_227_;
  wire [0:0] _zz_228_;
  wire [0:0] _zz_229_;
  wire [0:0] _zz_230_;
  wire [0:0] _zz_231_;
  wire [2:0] _zz_232_;
  wire [4:0] _zz_233_;
  wire [11:0] _zz_234_;
  wire [11:0] _zz_235_;
  wire [31:0] _zz_236_;
  wire [31:0] _zz_237_;
  wire [31:0] _zz_238_;
  wire [31:0] _zz_239_;
  wire [1:0] _zz_240_;
  wire [31:0] _zz_241_;
  wire [1:0] _zz_242_;
  wire [1:0] _zz_243_;
  wire [31:0] _zz_244_;
  wire [32:0] _zz_245_;
  wire [11:0] _zz_246_;
  wire [19:0] _zz_247_;
  wire [11:0] _zz_248_;
  wire [31:0] _zz_249_;
  wire [31:0] _zz_250_;
  wire [31:0] _zz_251_;
  wire [11:0] _zz_252_;
  wire [19:0] _zz_253_;
  wire [11:0] _zz_254_;
  wire [2:0] _zz_255_;
  wire [1:0] _zz_256_;
  wire [1:0] _zz_257_;
  wire [51:0] _zz_258_;
  wire [51:0] _zz_259_;
  wire [51:0] _zz_260_;
  wire [32:0] _zz_261_;
  wire [51:0] _zz_262_;
  wire [49:0] _zz_263_;
  wire [51:0] _zz_264_;
  wire [49:0] _zz_265_;
  wire [51:0] _zz_266_;
  wire [65:0] _zz_267_;
  wire [65:0] _zz_268_;
  wire [31:0] _zz_269_;
  wire [31:0] _zz_270_;
  wire [0:0] _zz_271_;
  wire [0:0] _zz_272_;
  wire [0:0] _zz_273_;
  wire [0:0] _zz_274_;
  wire [0:0] _zz_275_;
  wire [0:0] _zz_276_;
  wire [26:0] _zz_277_;
  wire [6:0] _zz_278_;
  wire  _zz_279_;
  wire  _zz_280_;
  wire [1:0] _zz_281_;
  wire [0:0] _zz_282_;
  wire [7:0] _zz_283_;
  wire  _zz_284_;
  wire [0:0] _zz_285_;
  wire [0:0] _zz_286_;
  wire [31:0] _zz_287_;
  wire  _zz_288_;
  wire [0:0] _zz_289_;
  wire [0:0] _zz_290_;
  wire [0:0] _zz_291_;
  wire [0:0] _zz_292_;
  wire [0:0] _zz_293_;
  wire [0:0] _zz_294_;
  wire  _zz_295_;
  wire [0:0] _zz_296_;
  wire [20:0] _zz_297_;
  wire [31:0] _zz_298_;
  wire [31:0] _zz_299_;
  wire [31:0] _zz_300_;
  wire [31:0] _zz_301_;
  wire [31:0] _zz_302_;
  wire  _zz_303_;
  wire [0:0] _zz_304_;
  wire [0:0] _zz_305_;
  wire [0:0] _zz_306_;
  wire [0:0] _zz_307_;
  wire [0:0] _zz_308_;
  wire [0:0] _zz_309_;
  wire  _zz_310_;
  wire [0:0] _zz_311_;
  wire [17:0] _zz_312_;
  wire [31:0] _zz_313_;
  wire [31:0] _zz_314_;
  wire [31:0] _zz_315_;
  wire [31:0] _zz_316_;
  wire [31:0] _zz_317_;
  wire  _zz_318_;
  wire [0:0] _zz_319_;
  wire [1:0] _zz_320_;
  wire [0:0] _zz_321_;
  wire [0:0] _zz_322_;
  wire [2:0] _zz_323_;
  wire [2:0] _zz_324_;
  wire  _zz_325_;
  wire [0:0] _zz_326_;
  wire [14:0] _zz_327_;
  wire [31:0] _zz_328_;
  wire [31:0] _zz_329_;
  wire [31:0] _zz_330_;
  wire [31:0] _zz_331_;
  wire [31:0] _zz_332_;
  wire [31:0] _zz_333_;
  wire  _zz_334_;
  wire  _zz_335_;
  wire [31:0] _zz_336_;
  wire [31:0] _zz_337_;
  wire [0:0] _zz_338_;
  wire [0:0] _zz_339_;
  wire [2:0] _zz_340_;
  wire [2:0] _zz_341_;
  wire  _zz_342_;
  wire [0:0] _zz_343_;
  wire [11:0] _zz_344_;
  wire [31:0] _zz_345_;
  wire [31:0] _zz_346_;
  wire [31:0] _zz_347_;
  wire [31:0] _zz_348_;
  wire [31:0] _zz_349_;
  wire [31:0] _zz_350_;
  wire [0:0] _zz_351_;
  wire [0:0] _zz_352_;
  wire [0:0] _zz_353_;
  wire [4:0] _zz_354_;
  wire [3:0] _zz_355_;
  wire [3:0] _zz_356_;
  wire  _zz_357_;
  wire [0:0] _zz_358_;
  wire [9:0] _zz_359_;
  wire [31:0] _zz_360_;
  wire [31:0] _zz_361_;
  wire [31:0] _zz_362_;
  wire  _zz_363_;
  wire [0:0] _zz_364_;
  wire [1:0] _zz_365_;
  wire [31:0] _zz_366_;
  wire [31:0] _zz_367_;
  wire  _zz_368_;
  wire [0:0] _zz_369_;
  wire [0:0] _zz_370_;
  wire  _zz_371_;
  wire [0:0] _zz_372_;
  wire [1:0] _zz_373_;
  wire  _zz_374_;
  wire [1:0] _zz_375_;
  wire [1:0] _zz_376_;
  wire  _zz_377_;
  wire [0:0] _zz_378_;
  wire [6:0] _zz_379_;
  wire [31:0] _zz_380_;
  wire [31:0] _zz_381_;
  wire [31:0] _zz_382_;
  wire  _zz_383_;
  wire  _zz_384_;
  wire [31:0] _zz_385_;
  wire [31:0] _zz_386_;
  wire [31:0] _zz_387_;
  wire [31:0] _zz_388_;
  wire [31:0] _zz_389_;
  wire [31:0] _zz_390_;
  wire  _zz_391_;
  wire [31:0] _zz_392_;
  wire  _zz_393_;
  wire  _zz_394_;
  wire  _zz_395_;
  wire [1:0] _zz_396_;
  wire [1:0] _zz_397_;
  wire  _zz_398_;
  wire [0:0] _zz_399_;
  wire [4:0] _zz_400_;
  wire [31:0] _zz_401_;
  wire [31:0] _zz_402_;
  wire [31:0] _zz_403_;
  wire [31:0] _zz_404_;
  wire [31:0] _zz_405_;
  wire [31:0] _zz_406_;
  wire  _zz_407_;
  wire [0:0] _zz_408_;
  wire [0:0] _zz_409_;
  wire [2:0] _zz_410_;
  wire [2:0] _zz_411_;
  wire  _zz_412_;
  wire [0:0] _zz_413_;
  wire [2:0] _zz_414_;
  wire [31:0] _zz_415_;
  wire [31:0] _zz_416_;
  wire [31:0] _zz_417_;
  wire  _zz_418_;
  wire  _zz_419_;
  wire [31:0] _zz_420_;
  wire [31:0] _zz_421_;
  wire [0:0] _zz_422_;
  wire [0:0] _zz_423_;
  wire [0:0] _zz_424_;
  wire [0:0] _zz_425_;
  wire  _zz_426_;
  wire  _zz_427_;
  wire [31:0] _zz_428_;
  wire [31:0] _zz_429_;
  wire [31:0] _zz_430_;
  wire [31:0] _zz_431_;
  wire  _zz_432_;
  wire  _zz_433_;
  wire  _zz_434_;
  wire [51:0] memory_MUL_LOW;
  wire  decode_RS1_USE;
  wire `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_1_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_2_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_3_;
  wire [31:0] execute_MUL_LL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_4_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_5_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_6_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_7_;
  wire `EnvCtrlEnum_defaultEncoding_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_8_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_9_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_10_;
  wire `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_11_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_12_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_13_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_14_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_15_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_16_;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_17_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_18_;
  wire  decode_RS2_USE;
  wire [31:0] memory_PC;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire [33:0] execute_MUL_HL;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire  decode_CSR_WRITE_OPCODE;
  wire  decode_CSR_READ_OPCODE;
  wire  decode_SRC_USE_SUB_LESS;
  wire  decode_MEMORY_ENABLE;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire [33:0] execute_MUL_LH;
  wire  execute_FLUSH_ALL;
  wire  decode_FLUSH_ALL;
  wire  execute_REGFILE_WRITE_VALID;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_19_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_20_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_21_;
  wire `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_22_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_23_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_24_;
  wire  decode_IS_CSR;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire  decode_PREDICTION_HAD_BRANCHED2;
  wire  decode_SRC_LESS_UNSIGNED;
  wire  execute_RS2_USE;
  wire  execute_RS1_USE;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  wire  writeBack_IS_MUL;
  wire [33:0] writeBack_MUL_HH;
  wire [51:0] writeBack_MUL_LOW;
  wire [33:0] memory_MUL_HL;
  wire [33:0] memory_MUL_LH;
  wire [31:0] memory_MUL_LL;
  wire [51:0] _zz_25_;
  wire [33:0] _zz_26_;
  wire [33:0] _zz_27_;
  wire [33:0] _zz_28_;
  wire [31:0] _zz_29_;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire  execute_IS_CSR;
  wire `EnvCtrlEnum_defaultEncoding_type memory_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_30_;
  wire `EnvCtrlEnum_defaultEncoding_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_31_;
  wire  _zz_32_;
  wire  _zz_33_;
  wire `EnvCtrlEnum_defaultEncoding_type writeBack_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_34_;
  wire  execute_IS_FENCEI;
  reg [31:0] _zz_35_;
  wire [31:0] execute_BRANCH_CALC;
  wire  execute_BRANCH_DO;
  wire [31:0] _zz_36_;
  wire [31:0] execute_PC;
  wire  execute_PREDICTION_HAD_BRANCHED2;
  wire  _zz_37_;
  wire [31:0] execute_RS1;
  wire  execute_BRANCH_COND_RESULT;
  wire `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_38_;
  wire  _zz_39_;
  wire  decode_IS_FENCEI;
  wire  _zz_40_;
  reg [31:0] _zz_41_;
  wire `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_42_;
  wire  _zz_43_;
  wire [31:0] _zz_44_;
  wire [31:0] _zz_45_;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_46_;
  wire `Src2CtrlEnum_defaultEncoding_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_47_;
  wire [31:0] _zz_48_;
  wire `Src1CtrlEnum_defaultEncoding_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_49_;
  wire [31:0] _zz_50_;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_51_;
  wire [31:0] _zz_52_;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_53_;
  wire [31:0] _zz_54_;
  wire  _zz_55_;
  reg  _zz_56_;
  wire [31:0] _zz_57_;
  wire [31:0] _zz_58_;
  reg  decode_REGFILE_WRITE_VALID;
  wire  _zz_59_;
  wire  _zz_60_;
  wire  _zz_61_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_62_;
  wire  _zz_63_;
  wire  _zz_64_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_65_;
  wire  _zz_66_;
  wire  _zz_67_;
  wire  _zz_68_;
  wire  _zz_69_;
  wire  _zz_70_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_71_;
  wire  _zz_72_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_73_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_74_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_75_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_76_;
  reg [31:0] _zz_77_;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire  memory_ALIGNEMENT_FAULT;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_MEMORY_ENABLE;
  wire [31:0] _zz_78_;
  wire [1:0] _zz_79_;
  wire [31:0] execute_RS2;
  wire [31:0] execute_SRC_ADD;
  wire [31:0] execute_INSTRUCTION;
  wire  execute_ALIGNEMENT_FAULT;
  wire  execute_MEMORY_ENABLE;
  wire  _zz_80_;
  wire  memory_FLUSH_ALL;
  reg  IBusCachedPlugin_rsp_issueDetected;
  wire `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_81_;
  reg [31:0] _zz_82_;
  reg [31:0] _zz_83_;
  wire [31:0] _zz_84_;
  wire [31:0] _zz_85_;
  wire [31:0] _zz_86_;
  wire [31:0] writeBack_PC /* verilator public */ ;
  wire [31:0] writeBack_INSTRUCTION /* verilator public */ ;
  wire [31:0] decode_PC /* verilator public */ ;
  wire [31:0] decode_INSTRUCTION /* verilator public */ ;
  wire  decode_arbitration_haltItself /* verilator public */ ;
  reg  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  reg  decode_arbitration_flushAll /* verilator public */ ;
  wire  decode_arbitration_redoIt;
  wire  decode_arbitration_isValid /* verilator public */ ;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  reg  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushAll;
  wire  execute_arbitration_redoIt;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  reg  memory_arbitration_flushAll;
  wire  memory_arbitration_redoIt;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  wire  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  wire  writeBack_arbitration_flushAll;
  wire  writeBack_arbitration_redoIt;
  reg  writeBack_arbitration_isValid /* verilator public */ ;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isMoving;
  wire  writeBack_arbitration_isFiring /* verilator public */ ;
  reg  _zz_87_;
  wire  _zz_88_;
  wire  _zz_89_;
  wire [31:0] _zz_90_;
  wire  _zz_91_;
  wire  _zz_92_;
  wire [31:0] _zz_93_;
  wire [31:0] _zz_94_;
  reg  memory_exception_agregat_valid;
  wire [3:0] memory_exception_agregat_payload_code;
  wire [31:0] memory_exception_agregat_payload_badAddr;
  wire  _zz_95_;
  wire [31:0] _zz_96_;
  reg  _zz_97_;
  reg  _zz_98_;
  reg [31:0] _zz_99_;
  wire  externalInterrupt;
  wire  contextSwitching;
  reg [1:0] CsrPlugin_privilege;
  reg  _zz_100_;
  reg [3:0] _zz_101_;
  wire  IBusCachedPlugin_jump_pcLoad_valid;
  wire [31:0] IBusCachedPlugin_jump_pcLoad_payload;
  wire [3:0] _zz_102_;
  wire [3:0] _zz_103_;
  wire  _zz_104_;
  wire  _zz_105_;
  wire  _zz_106_;
  wire  IBusCachedPlugin_fetchPc_preOutput_valid;
  wire  IBusCachedPlugin_fetchPc_preOutput_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_preOutput_payload;
  wire  _zz_107_;
  wire  IBusCachedPlugin_fetchPc_output_valid;
  wire  IBusCachedPlugin_fetchPc_output_ready;
  wire [31:0] IBusCachedPlugin_fetchPc_output_payload;
  reg [31:0] IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusCachedPlugin_fetchPc_inc;
  reg  IBusCachedPlugin_fetchPc_propagatePc;
  reg [31:0] IBusCachedPlugin_fetchPc_pc;
  reg  IBusCachedPlugin_fetchPc_samplePcNext;
  reg  _zz_108_;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_0_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_0_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_0_inputSample;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  wire  IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  reg  IBusCachedPlugin_iBusRsp_stages_1_halt;
  wire  IBusCachedPlugin_iBusRsp_stages_1_inputSample;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload;
  reg  IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt;
  wire  IBusCachedPlugin_iBusRsp_cacheRspArbitration_inputSample;
  wire  _zz_109_;
  wire  _zz_110_;
  wire  _zz_111_;
  wire  _zz_112_;
  wire  _zz_113_;
  reg  _zz_114_;
  wire  _zz_115_;
  reg  _zz_116_;
  reg [31:0] _zz_117_;
  wire  IBusCachedPlugin_iBusRsp_readyForError;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_valid;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_ready;
  wire [31:0] IBusCachedPlugin_iBusRsp_decodeInput_payload_pc;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_error;
  wire [31:0] IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_inst;
  wire  IBusCachedPlugin_iBusRsp_decodeInput_payload_isRvc;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_0;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_1;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_2;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_3;
  reg  IBusCachedPlugin_injector_nextPcCalc_valids_4;
  reg  IBusCachedPlugin_injector_decodeRemoved;
  wire  _zz_118_;
  reg [18:0] _zz_119_;
  wire  _zz_120_;
  reg [10:0] _zz_121_;
  wire  _zz_122_;
  reg [18:0] _zz_123_;
  wire  iBus_cmd_valid;
  wire  iBus_cmd_ready;
  reg [31:0] iBus_cmd_payload_address;
  wire [2:0] iBus_cmd_payload_size;
  wire  iBus_rsp_valid;
  wire [31:0] iBus_rsp_payload_data;
  wire  iBus_rsp_payload_error;
  wire  IBusCachedPlugin_s0_tightlyCoupledHit;
  reg  IBusCachedPlugin_s1_tightlyCoupledHit;
  reg  IBusCachedPlugin_s2_tightlyCoupledHit;
  wire  IBusCachedPlugin_rsp_iBusRspOutputHalt;
  reg  IBusCachedPlugin_rsp_redoFetch;
  wire  dBus_cmd_valid;
  wire  dBus_cmd_ready;
  wire  dBus_cmd_payload_wr;
  wire [31:0] dBus_cmd_payload_address;
  wire [31:0] dBus_cmd_payload_data;
  wire [1:0] dBus_cmd_payload_size;
  wire  dBus_rsp_ready;
  wire  dBus_rsp_error;
  wire [31:0] dBus_rsp_data;
  wire  execute_DBusSimplePlugin_cmdSent;
  reg [31:0] _zz_124_;
  reg [3:0] _zz_125_;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  _zz_126_;
  reg [31:0] _zz_127_;
  wire  _zz_128_;
  reg [31:0] _zz_129_;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  wire [26:0] _zz_130_;
  wire  _zz_131_;
  wire  _zz_132_;
  wire  _zz_133_;
  wire  _zz_134_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_135_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_136_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_137_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_138_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_139_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_140_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_141_;
  wire [31:0] execute_RegFilePlugin_srcInstruction;
  wire [4:0] execute_RegFilePlugin_regFileReadAddress1;
  wire [4:0] execute_RegFilePlugin_regFileReadAddress2;
  wire [31:0] execute_RegFilePlugin_rs1Data;
  wire [31:0] execute_RegFilePlugin_rs2Data;
  wire  writeBack_RegFilePlugin_regFileWrite_valid /* verilator public */ ;
  wire [4:0] writeBack_RegFilePlugin_regFileWrite_payload_address /* verilator public */ ;
  wire [31:0] writeBack_RegFilePlugin_regFileWrite_payload_data /* verilator public */ ;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_142_;
  reg [31:0] _zz_143_;
  wire  _zz_144_;
  reg [19:0] _zz_145_;
  wire  _zz_146_;
  reg [19:0] _zz_147_;
  reg [31:0] _zz_148_;
  wire [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  reg  execute_LightShifterPlugin_isActive;
  wire  execute_LightShifterPlugin_isShift;
  reg [4:0] execute_LightShifterPlugin_amplitudeReg;
  wire [4:0] execute_LightShifterPlugin_amplitude;
  wire [31:0] execute_LightShifterPlugin_shiftInput;
  wire  execute_LightShifterPlugin_done;
  reg [31:0] _zz_149_;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_150_;
  reg  _zz_151_;
  reg  _zz_152_;
  wire  _zz_153_;
  reg [19:0] _zz_154_;
  wire  _zz_155_;
  reg [10:0] _zz_156_;
  wire  _zz_157_;
  reg [18:0] _zz_158_;
  reg  _zz_159_;
  wire  execute_BranchPlugin_missAlignedTarget;
  reg [31:0] execute_BranchPlugin_branch_src1;
  reg [31:0] execute_BranchPlugin_branch_src2;
  wire  _zz_160_;
  reg [19:0] _zz_161_;
  wire  _zz_162_;
  reg [10:0] _zz_163_;
  wire  _zz_164_;
  reg [18:0] _zz_165_;
  wire [31:0] execute_BranchPlugin_branchAdder;
  wire [1:0] CsrPlugin_misa_base;
  wire [25:0] CsrPlugin_misa_extensions;
  reg [1:0] CsrPlugin_mtvec_mode;
  reg [29:0] CsrPlugin_mtvec_base;
  reg [31:0] CsrPlugin_mepc;
  reg  CsrPlugin_mstatus_MIE;
  reg  CsrPlugin_mstatus_MPIE;
  reg [1:0] CsrPlugin_mstatus_MPP;
  reg  CsrPlugin_mip_MEIP;
  reg  CsrPlugin_mip_MTIP;
  reg  CsrPlugin_mip_MSIP;
  reg  CsrPlugin_mie_MEIE;
  reg  CsrPlugin_mie_MTIE;
  reg  CsrPlugin_mie_MSIE;
  reg [31:0] CsrPlugin_mscratch;
  reg  CsrPlugin_mcause_interrupt;
  reg [3:0] CsrPlugin_mcause_exceptionCode;
  reg [31:0] CsrPlugin_mtval;
  reg [63:0] CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg [63:0] CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire [31:0] CsrPlugin_medeleg;
  wire [31:0] CsrPlugin_mideleg;
  wire  _zz_166_;
  wire  _zz_167_;
  wire  _zz_168_;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire  execute_exception_agregat_valid;
  wire [3:0] execute_exception_agregat_payload_code;
  wire [31:0] execute_exception_agregat_payload_badAddr;
  wire [1:0] _zz_169_;
  wire  _zz_170_;
  reg  CsrPlugin_interrupt;
  reg [3:0] CsrPlugin_interruptCode /* verilator public */ ;
  wire [1:0] CsrPlugin_interruptTargetPrivilege;
  wire  CsrPlugin_exception;
  wire  CsrPlugin_lastStageWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  CsrPlugin_hadException;
  reg [1:0] CsrPlugin_targetPrivilege;
  reg [3:0] CsrPlugin_trapCause;
  wire  execute_CsrPlugin_blockedBySideEffects;
  reg  execute_CsrPlugin_illegalAccess;
  reg  execute_CsrPlugin_illegalInstruction;
  reg [31:0] execute_CsrPlugin_readData;
  wire  execute_CsrPlugin_writeInstruction;
  wire  execute_CsrPlugin_readInstruction;
  wire  execute_CsrPlugin_writeEnable;
  wire  execute_CsrPlugin_readEnable;
  reg [31:0] execute_CsrPlugin_writeData;
  wire [11:0] execute_CsrPlugin_csrAddress;
  reg  execute_MulPlugin_aSigned;
  reg  execute_MulPlugin_bSigned;
  wire [31:0] execute_MulPlugin_a;
  wire [31:0] execute_MulPlugin_b;
  wire [15:0] execute_MulPlugin_aULow;
  wire [15:0] execute_MulPlugin_bULow;
  wire [16:0] execute_MulPlugin_aSLow;
  wire [16:0] execute_MulPlugin_bSLow;
  wire [16:0] execute_MulPlugin_aHigh;
  wire [16:0] execute_MulPlugin_bHigh;
  wire [65:0] writeBack_MulPlugin_result;
  reg  _zz_171_;
  reg  _zz_172_;
  wire  _zz_173_;
  reg  _zz_174_;
  reg [4:0] _zz_175_;
  reg [31:0] _zz_176_;
  reg [31:0] externalInterruptArray_regNext;
  wire [31:0] _zz_177_;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg  decode_to_execute_PREDICTION_HAD_BRANCHED2;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg  decode_to_execute_IS_CSR;
  reg `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  reg `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg  decode_to_execute_FLUSH_ALL;
  reg  execute_to_memory_FLUSH_ALL;
  reg [33:0] execute_to_memory_MUL_LH;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  reg [33:0] execute_to_memory_MUL_HL;
  reg  decode_to_execute_IS_FENCEI;
  reg [31:0] memory_to_writeBack_MEMORY_READ_DATA;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg  decode_to_execute_RS2_USE;
  reg `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  reg `Src1CtrlEnum_defaultEncoding_type decode_to_execute_SRC1_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type decode_to_execute_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type execute_to_memory_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type memory_to_writeBack_ENV_CTRL;
  reg [31:0] execute_to_memory_MUL_LL;
  reg  execute_to_memory_ALIGNEMENT_FAULT;
  reg `Src2CtrlEnum_defaultEncoding_type decode_to_execute_SRC2_CTRL;
  reg  decode_to_execute_RS1_USE;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg [2:0] _zz_178_;
  reg  _zz_179_;
  reg [31:0] iBusWishbone_DAT_MISO_regNext;
  wire  dBus_cmd_halfPipe_valid;
  wire  dBus_cmd_halfPipe_ready;
  wire  dBus_cmd_halfPipe_payload_wr;
  wire [31:0] dBus_cmd_halfPipe_payload_address;
  wire [31:0] dBus_cmd_halfPipe_payload_data;
  wire [1:0] dBus_cmd_halfPipe_payload_size;
  reg  dBus_cmd_halfPipe_regs_valid;
  reg  dBus_cmd_halfPipe_regs_ready;
  reg  dBus_cmd_halfPipe_regs_payload_wr;
  reg [31:0] dBus_cmd_halfPipe_regs_payload_address;
  reg [31:0] dBus_cmd_halfPipe_regs_payload_data;
  reg [1:0] dBus_cmd_halfPipe_regs_payload_size;
  reg [3:0] _zz_180_;
  `ifndef SYNTHESIS
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_1__string;
  reg [23:0] _zz_2__string;
  reg [23:0] _zz_3__string;
  reg [47:0] _zz_4__string;
  reg [47:0] _zz_5__string;
  reg [47:0] _zz_6__string;
  reg [47:0] _zz_7__string;
  reg [47:0] decode_ENV_CTRL_string;
  reg [47:0] _zz_8__string;
  reg [47:0] _zz_9__string;
  reg [47:0] _zz_10__string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_11__string;
  reg [95:0] _zz_12__string;
  reg [95:0] _zz_13__string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_14__string;
  reg [39:0] _zz_15__string;
  reg [39:0] _zz_16__string;
  reg [31:0] _zz_17__string;
  reg [31:0] _zz_18__string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_19__string;
  reg [71:0] _zz_20__string;
  reg [71:0] _zz_21__string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_22__string;
  reg [63:0] _zz_23__string;
  reg [63:0] _zz_24__string;
  reg [47:0] memory_ENV_CTRL_string;
  reg [47:0] _zz_30__string;
  reg [47:0] execute_ENV_CTRL_string;
  reg [47:0] _zz_31__string;
  reg [47:0] writeBack_ENV_CTRL_string;
  reg [47:0] _zz_34__string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_38__string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_42__string;
  reg [23:0] execute_SRC2_CTRL_string;
  reg [23:0] _zz_47__string;
  reg [95:0] execute_SRC1_CTRL_string;
  reg [95:0] _zz_49__string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_51__string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_53__string;
  reg [71:0] _zz_62__string;
  reg [39:0] _zz_65__string;
  reg [47:0] _zz_71__string;
  reg [23:0] _zz_73__string;
  reg [63:0] _zz_74__string;
  reg [31:0] _zz_75__string;
  reg [95:0] _zz_76__string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_81__string;
  reg [95:0] _zz_135__string;
  reg [31:0] _zz_136__string;
  reg [63:0] _zz_137__string;
  reg [23:0] _zz_138__string;
  reg [47:0] _zz_139__string;
  reg [39:0] _zz_140__string;
  reg [71:0] _zz_141__string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [95:0] decode_to_execute_SRC1_CTRL_string;
  reg [47:0] decode_to_execute_ENV_CTRL_string;
  reg [47:0] execute_to_memory_ENV_CTRL_string;
  reg [47:0] memory_to_writeBack_ENV_CTRL_string;
  reg [23:0] decode_to_execute_SRC2_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign _zz_200_ = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != (5'b00000)));
  assign _zz_201_ = (! execute_arbitration_isStuckByOthers);
  assign _zz_202_ = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign _zz_203_ = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign _zz_204_ = (IBusCachedPlugin_fetchPc_preOutput_valid && IBusCachedPlugin_fetchPc_preOutput_ready);
  assign _zz_205_ = (iBus_cmd_valid || (_zz_178_ != (3'b000)));
  assign _zz_206_ = (! dBus_cmd_halfPipe_regs_valid);
  assign _zz_207_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_208_ = writeBack_INSTRUCTION[29 : 28];
  assign _zz_209_ = execute_INSTRUCTION[13];
  assign _zz_210_ = execute_INSTRUCTION[13 : 12];
  assign _zz_211_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_212_ = (_zz_102_ - (4'b0001));
  assign _zz_213_ = {IBusCachedPlugin_fetchPc_inc,(2'b00)};
  assign _zz_214_ = {29'd0, _zz_213_};
  assign _zz_215_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_216_ = {{_zz_119_,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_217_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_218_ = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_219_ = (memory_INSTRUCTION[5] ? (3'b110) : (3'b100));
  assign _zz_220_ = _zz_130_[8 : 8];
  assign _zz_221_ = _zz_130_[11 : 11];
  assign _zz_222_ = _zz_130_[12 : 12];
  assign _zz_223_ = _zz_130_[13 : 13];
  assign _zz_224_ = _zz_130_[15 : 15];
  assign _zz_225_ = _zz_130_[16 : 16];
  assign _zz_226_ = _zz_130_[20 : 20];
  assign _zz_227_ = _zz_130_[21 : 21];
  assign _zz_228_ = _zz_130_[24 : 24];
  assign _zz_229_ = _zz_130_[25 : 25];
  assign _zz_230_ = _zz_130_[26 : 26];
  assign _zz_231_ = execute_SRC_LESS;
  assign _zz_232_ = (3'b100);
  assign _zz_233_ = execute_INSTRUCTION[19 : 15];
  assign _zz_234_ = execute_INSTRUCTION[31 : 20];
  assign _zz_235_ = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_236_ = ($signed(_zz_237_) + $signed(_zz_241_));
  assign _zz_237_ = ($signed(_zz_238_) + $signed(_zz_239_));
  assign _zz_238_ = execute_SRC1;
  assign _zz_239_ = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_240_ = (execute_SRC_USE_SUB_LESS ? _zz_242_ : _zz_243_);
  assign _zz_241_ = {{30{_zz_240_[1]}}, _zz_240_};
  assign _zz_242_ = (2'b01);
  assign _zz_243_ = (2'b00);
  assign _zz_244_ = (_zz_245_ >>> 1);
  assign _zz_245_ = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_246_ = execute_INSTRUCTION[31 : 20];
  assign _zz_247_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_248_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_249_ = {_zz_154_,execute_INSTRUCTION[31 : 20]};
  assign _zz_250_ = {{_zz_156_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
  assign _zz_251_ = {{_zz_158_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_252_ = execute_INSTRUCTION[31 : 20];
  assign _zz_253_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_254_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_255_ = (3'b100);
  assign _zz_256_ = (_zz_169_ & (~ _zz_257_));
  assign _zz_257_ = (_zz_169_ - (2'b01));
  assign _zz_258_ = ($signed(_zz_259_) + $signed(_zz_264_));
  assign _zz_259_ = ($signed(_zz_260_) + $signed(_zz_262_));
  assign _zz_260_ = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_261_ = {1'b0,memory_MUL_LL};
  assign _zz_262_ = {{19{_zz_261_[32]}}, _zz_261_};
  assign _zz_263_ = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_264_ = {{2{_zz_263_[49]}}, _zz_263_};
  assign _zz_265_ = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_266_ = {{2{_zz_265_[49]}}, _zz_265_};
  assign _zz_267_ = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_268_ = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_269_ = writeBack_MUL_LOW[31 : 0];
  assign _zz_270_ = writeBack_MulPlugin_result[63 : 32];
  assign _zz_271_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_272_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_273_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_274_ = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_275_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_276_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_277_ = (iBus_cmd_payload_address >>> 5);
  assign _zz_278_ = ({3'd0,_zz_180_} <<< dBus_cmd_halfPipe_payload_address[1 : 0]);
  assign _zz_279_ = 1'b1;
  assign _zz_280_ = 1'b1;
  assign _zz_281_ = {_zz_106_,_zz_105_};
  assign _zz_282_ = decode_INSTRUCTION[31];
  assign _zz_283_ = decode_INSTRUCTION[19 : 12];
  assign _zz_284_ = decode_INSTRUCTION[20];
  assign _zz_285_ = decode_INSTRUCTION[31];
  assign _zz_286_ = decode_INSTRUCTION[7];
  assign _zz_287_ = (32'b00000000000000000100000001001000);
  assign _zz_288_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000001000000));
  assign _zz_289_ = ((decode_INSTRUCTION & _zz_298_) == (32'b01000000000000000000000000110000));
  assign _zz_290_ = ((decode_INSTRUCTION & _zz_299_) == (32'b00000000000000000010000000010000));
  assign _zz_291_ = ((decode_INSTRUCTION & _zz_300_) == (32'b00000000000000000000000000100000));
  assign _zz_292_ = ((decode_INSTRUCTION & _zz_301_) == (32'b00000000000000000000000000100000));
  assign _zz_293_ = ((decode_INSTRUCTION & _zz_302_) == (32'b00000000000000000101000000010000));
  assign _zz_294_ = (1'b0);
  assign _zz_295_ = ({_zz_303_,{_zz_304_,_zz_305_}} != (3'b000));
  assign _zz_296_ = ({_zz_306_,_zz_307_} != (2'b00));
  assign _zz_297_ = {(_zz_308_ != _zz_309_),{_zz_310_,{_zz_311_,_zz_312_}}};
  assign _zz_298_ = (32'b01000000000000000000000000110000);
  assign _zz_299_ = (32'b00000000000000000010000000010100);
  assign _zz_300_ = (32'b00000000000000000000000000110100);
  assign _zz_301_ = (32'b00000000000000000000000001100100);
  assign _zz_302_ = (32'b00000000000000000111000001010100);
  assign _zz_303_ = ((decode_INSTRUCTION & (32'b01000000000000000011000001010100)) == (32'b01000000000000000001000000010000));
  assign _zz_304_ = ((decode_INSTRUCTION & _zz_313_) == (32'b00000000000000000001000000010000));
  assign _zz_305_ = ((decode_INSTRUCTION & _zz_314_) == (32'b00000000000000000001000000010000));
  assign _zz_306_ = ((decode_INSTRUCTION & _zz_315_) == (32'b00000000000000000001000001010000));
  assign _zz_307_ = ((decode_INSTRUCTION & _zz_316_) == (32'b00000000000000000010000001010000));
  assign _zz_308_ = ((decode_INSTRUCTION & _zz_317_) == (32'b00000000000000000000000000000000));
  assign _zz_309_ = (1'b0);
  assign _zz_310_ = ({_zz_318_,{_zz_319_,_zz_320_}} != (4'b0000));
  assign _zz_311_ = ({_zz_321_,_zz_322_} != (2'b00));
  assign _zz_312_ = {(_zz_323_ != _zz_324_),{_zz_325_,{_zz_326_,_zz_327_}}};
  assign _zz_313_ = (32'b00000000000000000111000000110100);
  assign _zz_314_ = (32'b00000010000000000111000001010100);
  assign _zz_315_ = (32'b00000000000000000001000001010000);
  assign _zz_316_ = (32'b00000000000000000010000001010000);
  assign _zz_317_ = (32'b00000000000000000000000001011000);
  assign _zz_318_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000001000000));
  assign _zz_319_ = ((decode_INSTRUCTION & _zz_328_) == (32'b00000000000000000100000000000000));
  assign _zz_320_ = {(_zz_329_ == _zz_330_),(_zz_331_ == _zz_332_)};
  assign _zz_321_ = ((decode_INSTRUCTION & _zz_333_) == (32'b00000000000000000001000000000000));
  assign _zz_322_ = _zz_133_;
  assign _zz_323_ = {_zz_133_,{_zz_334_,_zz_335_}};
  assign _zz_324_ = (3'b000);
  assign _zz_325_ = ((_zz_336_ == _zz_337_) != (1'b0));
  assign _zz_326_ = ({_zz_338_,_zz_339_} != (2'b00));
  assign _zz_327_ = {(_zz_340_ != _zz_341_),{_zz_342_,{_zz_343_,_zz_344_}}};
  assign _zz_328_ = (32'b00000000000000000100000000011000);
  assign _zz_329_ = (decode_INSTRUCTION & (32'b00000000000000000100000000110000));
  assign _zz_330_ = (32'b00000000000000000000000000000000);
  assign _zz_331_ = (decode_INSTRUCTION & (32'b00000000010000000011000001000000));
  assign _zz_332_ = (32'b00000000000000000000000001000000);
  assign _zz_333_ = (32'b00000000000000000001000000000000);
  assign _zz_334_ = ((decode_INSTRUCTION & _zz_345_) == (32'b00000000000000000001000000000000));
  assign _zz_335_ = ((decode_INSTRUCTION & _zz_346_) == (32'b00000000000000000010000000000000));
  assign _zz_336_ = (decode_INSTRUCTION & (32'b00000000000000000001000001001000));
  assign _zz_337_ = (32'b00000000000000000000000000001000);
  assign _zz_338_ = (_zz_347_ == _zz_348_);
  assign _zz_339_ = (_zz_349_ == _zz_350_);
  assign _zz_340_ = {_zz_133_,{_zz_351_,_zz_352_}};
  assign _zz_341_ = (3'b000);
  assign _zz_342_ = ({_zz_353_,_zz_354_} != (6'b000000));
  assign _zz_343_ = (_zz_355_ != _zz_356_);
  assign _zz_344_ = {_zz_357_,{_zz_358_,_zz_359_}};
  assign _zz_345_ = (32'b00000000000000000011000000000000);
  assign _zz_346_ = (32'b00000000000000000011000000000000);
  assign _zz_347_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_348_ = (32'b00000000000000000010000000000000);
  assign _zz_349_ = (decode_INSTRUCTION & (32'b00000000000000000101000000000000));
  assign _zz_350_ = (32'b00000000000000000001000000000000);
  assign _zz_351_ = _zz_134_;
  assign _zz_352_ = ((decode_INSTRUCTION & _zz_360_) == (32'b00000000000000000000000000100000));
  assign _zz_353_ = _zz_132_;
  assign _zz_354_ = {(_zz_361_ == _zz_362_),{_zz_363_,{_zz_364_,_zz_365_}}};
  assign _zz_355_ = {(_zz_366_ == _zz_367_),{_zz_368_,{_zz_369_,_zz_370_}}};
  assign _zz_356_ = (4'b0000);
  assign _zz_357_ = ({_zz_371_,{_zz_372_,_zz_373_}} != (4'b0000));
  assign _zz_358_ = (_zz_374_ != (1'b0));
  assign _zz_359_ = {(_zz_375_ != _zz_376_),{_zz_377_,{_zz_378_,_zz_379_}}};
  assign _zz_360_ = (32'b00000010000000000000000001100000);
  assign _zz_361_ = (decode_INSTRUCTION & (32'b00000000000000000001000000010000));
  assign _zz_362_ = (32'b00000000000000000001000000010000);
  assign _zz_363_ = ((decode_INSTRUCTION & _zz_380_) == (32'b00000000000000000010000000010000));
  assign _zz_364_ = (_zz_381_ == _zz_382_);
  assign _zz_365_ = {_zz_383_,_zz_384_};
  assign _zz_366_ = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_367_ = (32'b00000000000000000000000000000000);
  assign _zz_368_ = ((decode_INSTRUCTION & _zz_385_) == (32'b00000000000000000000000000000000));
  assign _zz_369_ = (_zz_386_ == _zz_387_);
  assign _zz_370_ = (_zz_388_ == _zz_389_);
  assign _zz_371_ = ((decode_INSTRUCTION & _zz_390_) == (32'b00000000000000000000000001000000));
  assign _zz_372_ = _zz_133_;
  assign _zz_373_ = {_zz_134_,_zz_391_};
  assign _zz_374_ = ((decode_INSTRUCTION & _zz_392_) == (32'b00000000000000000000000001010000));
  assign _zz_375_ = {_zz_393_,_zz_394_};
  assign _zz_376_ = (2'b00);
  assign _zz_377_ = (_zz_395_ != (1'b0));
  assign _zz_378_ = (_zz_396_ != _zz_397_);
  assign _zz_379_ = {_zz_398_,{_zz_399_,_zz_400_}};
  assign _zz_380_ = (32'b00000000000000000010000000010000);
  assign _zz_381_ = (decode_INSTRUCTION & (32'b00000000000000000000000001010000));
  assign _zz_382_ = (32'b00000000000000000000000000010000);
  assign _zz_383_ = ((decode_INSTRUCTION & _zz_401_) == (32'b00000000000000000000000000000000));
  assign _zz_384_ = ((decode_INSTRUCTION & _zz_402_) == (32'b00000000000000000000000000000100));
  assign _zz_385_ = (32'b00000000000000000000000000011000);
  assign _zz_386_ = (decode_INSTRUCTION & (32'b00000000000000000110000000000100));
  assign _zz_387_ = (32'b00000000000000000010000000000000);
  assign _zz_388_ = (decode_INSTRUCTION & (32'b00000000000000000101000000000100));
  assign _zz_389_ = (32'b00000000000000000001000000000000);
  assign _zz_390_ = (32'b00000000000000000000000001000000);
  assign _zz_391_ = ((decode_INSTRUCTION & _zz_403_) == (32'b00000000000000000000000000100000));
  assign _zz_392_ = (32'b00010000000000000011000001010000);
  assign _zz_393_ = ((decode_INSTRUCTION & _zz_404_) == (32'b00000000000100000000000001010000));
  assign _zz_394_ = ((decode_INSTRUCTION & _zz_405_) == (32'b00010000000000000000000001010000));
  assign _zz_395_ = ((decode_INSTRUCTION & _zz_406_) == (32'b00000010000000000000000000110000));
  assign _zz_396_ = {_zz_133_,_zz_407_};
  assign _zz_397_ = (2'b00);
  assign _zz_398_ = ({_zz_408_,_zz_409_} != (2'b00));
  assign _zz_399_ = (_zz_410_ != _zz_411_);
  assign _zz_400_ = {_zz_412_,{_zz_413_,_zz_414_}};
  assign _zz_401_ = (32'b00000000000000000000000000101000);
  assign _zz_402_ = (32'b00000000000000000101000000000100);
  assign _zz_403_ = (32'b00000010000000000000000000100000);
  assign _zz_404_ = (32'b00010000000100000011000001010000);
  assign _zz_405_ = (32'b00010000010000000011000001010000);
  assign _zz_406_ = (32'b00000010000000000000000001110100);
  assign _zz_407_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_408_ = _zz_133_;
  assign _zz_409_ = ((decode_INSTRUCTION & _zz_415_) == (32'b00000000000000000000000000000000));
  assign _zz_410_ = {(_zz_416_ == _zz_417_),{_zz_418_,_zz_419_}};
  assign _zz_411_ = (3'b000);
  assign _zz_412_ = ((_zz_420_ == _zz_421_) != (1'b0));
  assign _zz_413_ = ({_zz_422_,_zz_423_} != (2'b00));
  assign _zz_414_ = {(_zz_424_ != _zz_425_),{_zz_426_,_zz_427_}};
  assign _zz_415_ = (32'b00000000000000000000000000100000);
  assign _zz_416_ = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_417_ = (32'b00000000000000000000000000100100);
  assign _zz_418_ = ((decode_INSTRUCTION & (32'b00000000000000000100000000010100)) == (32'b00000000000000000100000000010000));
  assign _zz_419_ = ((decode_INSTRUCTION & (32'b00000000000000000011000000010100)) == (32'b00000000000000000001000000010000));
  assign _zz_420_ = (decode_INSTRUCTION & (32'b00000000000000000110000000010100));
  assign _zz_421_ = (32'b00000000000000000010000000010000);
  assign _zz_422_ = _zz_132_;
  assign _zz_423_ = ((decode_INSTRUCTION & (32'b00000000000000000100000000010100)) == (32'b00000000000000000000000000000100));
  assign _zz_424_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001011000)) == (32'b00000000000000000000000001000000));
  assign _zz_425_ = (1'b0);
  assign _zz_426_ = ({(_zz_428_ == _zz_429_),_zz_131_} != (2'b00));
  assign _zz_427_ = ({(_zz_430_ == _zz_431_),_zz_131_} != (2'b00));
  assign _zz_428_ = (decode_INSTRUCTION & (32'b00000000000000000000000000010100));
  assign _zz_429_ = (32'b00000000000000000000000000000100);
  assign _zz_430_ = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_431_ = (32'b00000000000000000000000000000100);
  assign _zz_432_ = execute_INSTRUCTION[31];
  assign _zz_433_ = execute_INSTRUCTION[31];
  assign _zz_434_ = execute_INSTRUCTION[7];
  always @ (posedge clk) begin
    if(_zz_56_) begin
      RegFilePlugin_regFile[writeBack_RegFilePlugin_regFileWrite_payload_address] <= writeBack_RegFilePlugin_regFileWrite_payload_data;
    end
  end

  always @ (posedge clk) begin
    if(_zz_279_) begin
      _zz_197_ <= RegFilePlugin_regFile[execute_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clk) begin
    if(_zz_280_) begin
      _zz_198_ <= RegFilePlugin_regFile[execute_RegFilePlugin_regFileReadAddress2];
    end
  end

  InstructionCache IBusCachedPlugin_cache ( 
    .io_flush_cmd_valid(_zz_181_),
    .io_flush_cmd_ready(IBusCachedPlugin_cache_io_flush_cmd_ready),
    .io_flush_rsp(IBusCachedPlugin_cache_io_flush_rsp),
    .io_cpu_prefetch_isValid(_zz_182_),
    .io_cpu_prefetch_haltIt(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt),
    .io_cpu_prefetch_pc(IBusCachedPlugin_iBusRsp_stages_0_input_payload),
    .io_cpu_fetch_isValid(_zz_183_),
    .io_cpu_fetch_isStuck(_zz_184_),
    .io_cpu_fetch_isRemoved(_zz_185_),
    .io_cpu_fetch_pc(IBusCachedPlugin_iBusRsp_stages_1_input_payload),
    .io_cpu_fetch_data(IBusCachedPlugin_cache_io_cpu_fetch_data),
    .io_cpu_fetch_dataBypassValid(IBusCachedPlugin_s1_tightlyCoupledHit),
    .io_cpu_fetch_dataBypass(_zz_186_),
    .io_cpu_fetch_mmuBus_cmd_isValid(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid),
    .io_cpu_fetch_mmuBus_cmd_virtualAddress(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress),
    .io_cpu_fetch_mmuBus_cmd_bypassTranslation(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_bypassTranslation),
    .io_cpu_fetch_mmuBus_rsp_physicalAddress(_zz_94_),
    .io_cpu_fetch_mmuBus_rsp_isIoAccess(_zz_187_),
    .io_cpu_fetch_mmuBus_rsp_allowRead(_zz_188_),
    .io_cpu_fetch_mmuBus_rsp_allowWrite(_zz_189_),
    .io_cpu_fetch_mmuBus_rsp_allowExecute(_zz_190_),
    .io_cpu_fetch_mmuBus_rsp_allowUser(_zz_191_),
    .io_cpu_fetch_mmuBus_rsp_miss(_zz_192_),
    .io_cpu_fetch_mmuBus_rsp_hit(_zz_193_),
    .io_cpu_fetch_mmuBus_end(IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_end),
    .io_cpu_fetch_physicalAddress(IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress),
    .io_cpu_decode_isValid(_zz_194_),
    .io_cpu_decode_isStuck(_zz_195_),
    .io_cpu_decode_pc(IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload),
    .io_cpu_decode_physicalAddress(IBusCachedPlugin_cache_io_cpu_decode_physicalAddress),
    .io_cpu_decode_data(IBusCachedPlugin_cache_io_cpu_decode_data),
    .io_cpu_decode_cacheMiss(IBusCachedPlugin_cache_io_cpu_decode_cacheMiss),
    .io_cpu_decode_error(IBusCachedPlugin_cache_io_cpu_decode_error),
    .io_cpu_decode_mmuMiss(IBusCachedPlugin_cache_io_cpu_decode_mmuMiss),
    .io_cpu_decode_illegalAccess(IBusCachedPlugin_cache_io_cpu_decode_illegalAccess),
    .io_cpu_decode_isUser(_zz_196_),
    .io_cpu_fill_valid(IBusCachedPlugin_rsp_redoFetch),
    .io_cpu_fill_payload(IBusCachedPlugin_cache_io_cpu_decode_physicalAddress),
    .io_mem_cmd_valid(IBusCachedPlugin_cache_io_mem_cmd_valid),
    .io_mem_cmd_ready(iBus_cmd_ready),
    .io_mem_cmd_payload_address(IBusCachedPlugin_cache_io_mem_cmd_payload_address),
    .io_mem_cmd_payload_size(IBusCachedPlugin_cache_io_mem_cmd_payload_size),
    .io_mem_rsp_valid(iBus_rsp_valid),
    .io_mem_rsp_payload_data(iBus_rsp_payload_data),
    .io_mem_rsp_payload_error(iBus_rsp_payload_error),
    .clk(clk),
    .reset(reset) 
  );
  always @(*) begin
    case(_zz_281_)
      2'b00 : begin
        _zz_199_ = _zz_99_;
      end
      2'b01 : begin
        _zz_199_ = _zz_96_;
      end
      2'b10 : begin
        _zz_199_ = _zz_93_;
      end
      default : begin
        _zz_199_ = _zz_90_;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_1_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_1__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_1__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_1__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_1__string = "PC ";
      default : _zz_1__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_2_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_2__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_2__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_2__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_2__string = "PC ";
      default : _zz_2__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_3_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_3__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_3__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_3__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_3__string = "PC ";
      default : _zz_3__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_4_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_4__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_4__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_4__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_4__string = "EBREAK";
      default : _zz_4__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_5_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_5__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_5__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_5__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_5__string = "EBREAK";
      default : _zz_5__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_6_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_6__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_6__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_6__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_6__string = "EBREAK";
      default : _zz_6__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_7_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_7__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_7__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_7__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_7__string = "EBREAK";
      default : _zz_7__string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : decode_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : decode_ENV_CTRL_string = "EBREAK";
      default : decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_8_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_8__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_8__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_8__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_8__string = "EBREAK";
      default : _zz_8__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_9_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_9__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_9__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_9__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_9__string = "EBREAK";
      default : _zz_9__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_10_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_10__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_10__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_10__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_10__string = "EBREAK";
      default : _zz_10__string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_11_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_11__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_11__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_11__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_11__string = "URS1        ";
      default : _zz_11__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_12_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_12__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_12__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_12__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_12__string = "URS1        ";
      default : _zz_12__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_13_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_13__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_13__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_13__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_13__string = "URS1        ";
      default : _zz_13__string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : decode_ALU_BITWISE_CTRL_string = "SRC1 ";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_14_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_14__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_14__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_14__string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : _zz_14__string = "SRC1 ";
      default : _zz_14__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_15_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_15__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_15__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_15__string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : _zz_15__string = "SRC1 ";
      default : _zz_15__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_16_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_16__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_16__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_16__string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : _zz_16__string = "SRC1 ";
      default : _zz_16__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_17_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_17__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_17__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_17__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_17__string = "JALR";
      default : _zz_17__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_18_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_18__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_18__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_18__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_18__string = "JALR";
      default : _zz_18__string = "????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_19_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_19__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_19__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_19__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_19__string = "SRA_1    ";
      default : _zz_19__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_20_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_20__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_20__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_20__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_20__string = "SRA_1    ";
      default : _zz_20__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_21_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_21__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_21__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_21__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_21__string = "SRA_1    ";
      default : _zz_21__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_22_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_22__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_22__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_22__string = "BITWISE ";
      default : _zz_22__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_23_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_23__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_23__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_23__string = "BITWISE ";
      default : _zz_23__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_24_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_24__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_24__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_24__string = "BITWISE ";
      default : _zz_24__string = "????????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : memory_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : memory_ENV_CTRL_string = "EBREAK";
      default : memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_30_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_30__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_30__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_30__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_30__string = "EBREAK";
      default : _zz_30__string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : execute_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : execute_ENV_CTRL_string = "EBREAK";
      default : execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_31_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_31__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_31__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_31__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_31__string = "EBREAK";
      default : _zz_31__string = "??????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : writeBack_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : writeBack_ENV_CTRL_string = "EBREAK";
      default : writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_34_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_34__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_34__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_34__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_34__string = "EBREAK";
      default : _zz_34__string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_38_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_38__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_38__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_38__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_38__string = "JALR";
      default : _zz_38__string = "????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_42_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_42__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_42__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_42__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_42__string = "SRA_1    ";
      default : _zz_42__string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : execute_SRC2_CTRL_string = "PC ";
      default : execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_47_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_47__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_47__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_47__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_47__string = "PC ";
      default : _zz_47__string = "???";
    endcase
  end
  always @(*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : execute_SRC1_CTRL_string = "URS1        ";
      default : execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_49_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_49__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_49__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_49__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_49__string = "URS1        ";
      default : _zz_49__string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_51_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_51__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_51__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_51__string = "BITWISE ";
      default : _zz_51__string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : execute_ALU_BITWISE_CTRL_string = "SRC1 ";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_53_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_53__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_53__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_53__string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : _zz_53__string = "SRC1 ";
      default : _zz_53__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_62_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_62__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_62__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_62__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_62__string = "SRA_1    ";
      default : _zz_62__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_65_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_65__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_65__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_65__string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : _zz_65__string = "SRC1 ";
      default : _zz_65__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_71_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_71__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_71__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_71__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_71__string = "EBREAK";
      default : _zz_71__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_73_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_73__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_73__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_73__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_73__string = "PC ";
      default : _zz_73__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_74_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_74__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_74__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_74__string = "BITWISE ";
      default : _zz_74__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_75_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_75__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_75__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_75__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_75__string = "JALR";
      default : _zz_75__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_76_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_76__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_76__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_76__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_76__string = "URS1        ";
      default : _zz_76__string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_81_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_81__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_81__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_81__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_81__string = "JALR";
      default : _zz_81__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_135_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_135__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_135__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_135__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_135__string = "URS1        ";
      default : _zz_135__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_136_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_136__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_136__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_136__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_136__string = "JALR";
      default : _zz_136__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_137_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_137__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_137__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_137__string = "BITWISE ";
      default : _zz_137__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_138_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_138__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_138__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_138__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_138__string = "PC ";
      default : _zz_138__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_139_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_139__string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_139__string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_139__string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_139__string = "EBREAK";
      default : _zz_139__string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_140_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_140__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_140__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_140__string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : _zz_140__string = "SRC1 ";
      default : _zz_140__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_141_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_141__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_141__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_141__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_141__string = "SRA_1    ";
      default : _zz_141__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      `AluBitwiseCtrlEnum_defaultEncoding_SRC1 : decode_to_execute_ALU_BITWISE_CTRL_string = "SRC1 ";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_to_execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_to_execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_to_execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : decode_to_execute_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_to_memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_to_memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : execute_to_memory_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : memory_to_writeBack_ENV_CTRL_string = "ECALL ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_to_execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_to_execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_to_execute_SRC2_CTRL_string = "PC ";
      default : decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  `endif

  assign memory_MUL_LOW = _zz_25_;
  assign decode_RS1_USE = _zz_69_;
  assign decode_SRC2_CTRL = _zz_1_;
  assign _zz_2_ = _zz_3_;
  assign execute_MUL_LL = _zz_29_;
  assign _zz_4_ = _zz_5_;
  assign _zz_6_ = _zz_7_;
  assign decode_ENV_CTRL = _zz_8_;
  assign _zz_9_ = _zz_10_;
  assign decode_SRC1_CTRL = _zz_11_;
  assign _zz_12_ = _zz_13_;
  assign decode_ALU_BITWISE_CTRL = _zz_14_;
  assign _zz_15_ = _zz_16_;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_52_;
  assign _zz_17_ = _zz_18_;
  assign decode_RS2_USE = _zz_61_;
  assign memory_PC = execute_to_memory_PC;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_79_;
  assign memory_MEMORY_READ_DATA = _zz_78_;
  assign execute_MUL_HL = _zz_27_;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_72_;
  assign decode_CSR_WRITE_OPCODE = _zz_33_;
  assign decode_CSR_READ_OPCODE = _zz_32_;
  assign decode_SRC_USE_SUB_LESS = _zz_60_;
  assign decode_MEMORY_ENABLE = _zz_64_;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_70_;
  assign execute_MUL_LH = _zz_28_;
  assign execute_FLUSH_ALL = decode_to_execute_FLUSH_ALL;
  assign decode_FLUSH_ALL = _zz_66_;
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = _zz_26_;
  assign decode_SHIFT_CTRL = _zz_19_;
  assign _zz_20_ = _zz_21_;
  assign decode_ALU_CTRL = _zz_22_;
  assign _zz_23_ = _zz_24_;
  assign decode_IS_CSR = _zz_63_;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_84_;
  assign decode_PREDICTION_HAD_BRANCHED2 = _zz_40_;
  assign decode_SRC_LESS_UNSIGNED = _zz_67_;
  assign execute_RS2_USE = decode_to_execute_RS2_USE;
  assign execute_RS1_USE = decode_to_execute_RS1_USE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_30_;
  assign execute_ENV_CTRL = _zz_31_;
  assign writeBack_ENV_CTRL = _zz_34_;
  assign execute_IS_FENCEI = decode_to_execute_IS_FENCEI;
  always @ (*) begin
    _zz_35_ = decode_INSTRUCTION;
    if(decode_IS_FENCEI)begin
      _zz_35_[12] = 1'b0;
      _zz_35_[22] = 1'b1;
    end
  end

  assign execute_BRANCH_CALC = _zz_36_;
  assign execute_BRANCH_DO = _zz_37_;
  assign execute_PC = decode_to_execute_PC;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_RS1 = _zz_58_;
  assign execute_BRANCH_COND_RESULT = _zz_39_;
  assign execute_BRANCH_CTRL = _zz_38_;
  assign decode_IS_FENCEI = _zz_59_;
  always @ (*) begin
    _zz_41_ = execute_REGFILE_WRITE_DATA;
    execute_arbitration_haltItself = 1'b0;
    if(((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_ALIGNEMENT_FAULT)) && (! execute_DBusSimplePlugin_cmdSent)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(_zz_200_)begin
      _zz_41_ = _zz_149_;
      if(_zz_201_)begin
        if(! execute_LightShifterPlugin_done) begin
          execute_arbitration_haltItself = 1'b1;
        end
      end
    end
    if((execute_arbitration_isValid && execute_IS_CSR))begin
      _zz_41_ = execute_CsrPlugin_readData;
      if(execute_CsrPlugin_blockedBySideEffects)begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign execute_SHIFT_CTRL = _zz_42_;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_46_ = execute_PC;
  assign execute_SRC2_CTRL = _zz_47_;
  assign execute_SRC1_CTRL = _zz_49_;
  assign execute_SRC_ADD_SUB = _zz_45_;
  assign execute_SRC_LESS = _zz_43_;
  assign execute_ALU_CTRL = _zz_51_;
  assign execute_SRC2 = _zz_48_;
  assign execute_SRC1 = _zz_50_;
  assign execute_ALU_BITWISE_CTRL = _zz_53_;
  assign _zz_54_ = writeBack_INSTRUCTION;
  assign _zz_55_ = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_56_ = 1'b0;
    if(writeBack_RegFilePlugin_regFileWrite_valid)begin
      _zz_56_ = 1'b1;
    end
  end

  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_68_;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @ (*) begin
    _zz_77_ = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_77_ = writeBack_DBusSimplePlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_211_)
        2'b00 : begin
          _zz_77_ = _zz_269_;
        end
        default : begin
          _zz_77_ = _zz_270_;
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign memory_ALIGNEMENT_FAULT = execute_to_memory_ALIGNEMENT_FAULT;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_RS2 = _zz_57_;
  assign execute_SRC_ADD = _zz_44_;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_ALIGNEMENT_FAULT = _zz_80_;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign memory_FLUSH_ALL = execute_to_memory_FLUSH_ALL;
  always @ (*) begin
    IBusCachedPlugin_rsp_issueDetected = 1'b0;
    IBusCachedPlugin_rsp_redoFetch = 1'b0;
    if(((_zz_194_ && IBusCachedPlugin_cache_io_cpu_decode_cacheMiss) && (! 1'b0)))begin
      IBusCachedPlugin_rsp_issueDetected = 1'b1;
      IBusCachedPlugin_rsp_redoFetch = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  assign decode_BRANCH_CTRL = _zz_81_;
  always @ (*) begin
    _zz_82_ = execute_FORMAL_PC_NEXT;
    if(_zz_95_)begin
      _zz_82_ = _zz_96_;
    end
  end

  always @ (*) begin
    _zz_83_ = decode_FORMAL_PC_NEXT;
    if(_zz_89_)begin
      _zz_83_ = _zz_90_;
    end
    if(_zz_92_)begin
      _zz_83_ = _zz_93_;
    end
  end

  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_PC = _zz_86_;
  assign decode_INSTRUCTION = _zz_85_;
  assign decode_arbitration_haltItself = 1'b0;
  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if((CsrPlugin_interrupt && decode_arbitration_isValid))begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(({(memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET))} != (2'b00)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_flushAll = 1'b0;
    execute_arbitration_removeIt = 1'b0;
    if(_zz_95_)begin
      decode_arbitration_flushAll = 1'b1;
    end
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(execute_exception_agregat_valid)begin
      decode_arbitration_flushAll = 1'b1;
      execute_arbitration_removeIt = 1'b1;
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_redoIt = 1'b0;
  always @ (*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(((execute_arbitration_isValid && execute_IS_FENCEI) && ({writeBack_arbitration_isValid,memory_arbitration_isValid} != (2'b00))))begin
      execute_arbitration_haltByOther = 1'b1;
    end
    if((execute_arbitration_isValid && (_zz_171_ || _zz_172_)))begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushAll = 1'b0;
    if(memory_exception_agregat_valid)begin
      execute_arbitration_flushAll = 1'b1;
    end
  end

  assign execute_arbitration_redoIt = 1'b0;
  always @ (*) begin
    memory_arbitration_haltItself = 1'b0;
    _zz_181_ = 1'b0;
    if((memory_arbitration_isValid && memory_FLUSH_ALL))begin
      _zz_181_ = 1'b1;
      if((! IBusCachedPlugin_cache_io_flush_cmd_ready))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_INSTRUCTION[5])) && (! dBus_rsp_ready)))begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_exception_agregat_valid)begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_flushAll = 1'b0;
    _zz_98_ = 1'b0;
    _zz_99_ = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    if(_zz_202_)begin
      _zz_98_ = 1'b1;
      _zz_99_ = {CsrPlugin_mtvec_base,(2'b00)};
      memory_arbitration_flushAll = 1'b1;
    end
    if(_zz_203_)begin
      _zz_99_ = CsrPlugin_mepc;
      _zz_98_ = 1'b1;
      memory_arbitration_flushAll = 1'b1;
    end
  end

  assign memory_arbitration_redoIt = 1'b0;
  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushAll = 1'b0;
  assign writeBack_arbitration_redoIt = 1'b0;
  always @ (*) begin
    _zz_87_ = 1'b0;
    if(({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode}}} != (4'b0000)))begin
      _zz_87_ = 1'b1;
    end
  end

  assign _zz_88_ = 1'b0;
  assign IBusCachedPlugin_jump_pcLoad_valid = ({_zz_98_,{_zz_95_,{_zz_92_,_zz_89_}}} != (4'b0000));
  assign _zz_102_ = {_zz_89_,{_zz_92_,{_zz_95_,_zz_98_}}};
  assign _zz_103_ = (_zz_102_ & (~ _zz_212_));
  assign _zz_104_ = _zz_103_[3];
  assign _zz_105_ = (_zz_103_[1] || _zz_104_);
  assign _zz_106_ = (_zz_103_[2] || _zz_104_);
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_199_;
  assign _zz_107_ = (! _zz_87_);
  assign IBusCachedPlugin_fetchPc_output_valid = (IBusCachedPlugin_fetchPc_preOutput_valid && _zz_107_);
  assign IBusCachedPlugin_fetchPc_preOutput_ready = (IBusCachedPlugin_fetchPc_output_ready && _zz_107_);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_preOutput_payload;
  always @ (*) begin
    IBusCachedPlugin_fetchPc_propagatePc = 1'b0;
    if((IBusCachedPlugin_iBusRsp_stages_1_input_valid && IBusCachedPlugin_iBusRsp_stages_1_input_ready))begin
      IBusCachedPlugin_fetchPc_propagatePc = 1'b1;
    end
  end

  always @ (*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_214_);
    IBusCachedPlugin_fetchPc_samplePcNext = 1'b0;
    if(IBusCachedPlugin_fetchPc_propagatePc)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    if(_zz_204_)begin
      IBusCachedPlugin_fetchPc_samplePcNext = 1'b1;
    end
    IBusCachedPlugin_fetchPc_pc[0] = 1'b0;
    IBusCachedPlugin_fetchPc_pc[1] = 1'b0;
  end

  assign IBusCachedPlugin_fetchPc_preOutput_valid = _zz_108_;
  assign IBusCachedPlugin_fetchPc_preOutput_payload = IBusCachedPlugin_fetchPc_pc;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid;
  assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_inputSample = 1'b1;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0;
    if(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt)begin
      IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_109_ = (! IBusCachedPlugin_iBusRsp_stages_0_halt);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = (IBusCachedPlugin_iBusRsp_stages_0_output_ready && _zz_109_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && _zz_109_);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0;
    if(((IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_isValid && (! 1'b1)) && (! 1'b0)))begin
      IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
    end
  end

  assign _zz_110_ = (! IBusCachedPlugin_iBusRsp_stages_1_halt);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = (IBusCachedPlugin_iBusRsp_stages_1_output_ready && _zz_110_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && _zz_110_);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  always @ (*) begin
    IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt = 1'b0;
    if((IBusCachedPlugin_rsp_issueDetected || IBusCachedPlugin_rsp_iBusRspOutputHalt))begin
      IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt = 1'b1;
    end
  end

  assign _zz_111_ = (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_halt);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready && _zz_111_);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid && _zz_111_);
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload = IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = _zz_112_;
  assign _zz_112_ = ((1'b0 && (! _zz_113_)) || IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign _zz_113_ = _zz_114_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = _zz_113_;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_fetchPc_pcReg;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! _zz_115_)) || IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready);
  assign _zz_115_ = _zz_116_;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid = _zz_115_;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload = _zz_117_;
  assign IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
  assign IBusCachedPlugin_iBusRsp_decodeInput_ready = (! decode_arbitration_isStuck);
  assign decode_arbitration_isValid = (IBusCachedPlugin_iBusRsp_decodeInput_valid && (! IBusCachedPlugin_injector_decodeRemoved));
  assign _zz_86_ = IBusCachedPlugin_iBusRsp_decodeInput_payload_pc;
  assign _zz_85_ = IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_inst;
  assign _zz_84_ = (decode_PC + (32'b00000000000000000000000000000100));
  assign _zz_118_ = _zz_215_[11];
  always @ (*) begin
    _zz_119_[18] = _zz_118_;
    _zz_119_[17] = _zz_118_;
    _zz_119_[16] = _zz_118_;
    _zz_119_[15] = _zz_118_;
    _zz_119_[14] = _zz_118_;
    _zz_119_[13] = _zz_118_;
    _zz_119_[12] = _zz_118_;
    _zz_119_[11] = _zz_118_;
    _zz_119_[10] = _zz_118_;
    _zz_119_[9] = _zz_118_;
    _zz_119_[8] = _zz_118_;
    _zz_119_[7] = _zz_118_;
    _zz_119_[6] = _zz_118_;
    _zz_119_[5] = _zz_118_;
    _zz_119_[4] = _zz_118_;
    _zz_119_[3] = _zz_118_;
    _zz_119_[2] = _zz_118_;
    _zz_119_[1] = _zz_118_;
    _zz_119_[0] = _zz_118_;
  end

  assign _zz_91_ = ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_B) && _zz_216_[31]));
  assign _zz_89_ = (_zz_91_ && decode_arbitration_isFiring);
  assign _zz_120_ = _zz_217_[19];
  always @ (*) begin
    _zz_121_[10] = _zz_120_;
    _zz_121_[9] = _zz_120_;
    _zz_121_[8] = _zz_120_;
    _zz_121_[7] = _zz_120_;
    _zz_121_[6] = _zz_120_;
    _zz_121_[5] = _zz_120_;
    _zz_121_[4] = _zz_120_;
    _zz_121_[3] = _zz_120_;
    _zz_121_[2] = _zz_120_;
    _zz_121_[1] = _zz_120_;
    _zz_121_[0] = _zz_120_;
  end

  assign _zz_122_ = _zz_218_[11];
  always @ (*) begin
    _zz_123_[18] = _zz_122_;
    _zz_123_[17] = _zz_122_;
    _zz_123_[16] = _zz_122_;
    _zz_123_[15] = _zz_122_;
    _zz_123_[14] = _zz_122_;
    _zz_123_[13] = _zz_122_;
    _zz_123_[12] = _zz_122_;
    _zz_123_[11] = _zz_122_;
    _zz_123_[10] = _zz_122_;
    _zz_123_[9] = _zz_122_;
    _zz_123_[8] = _zz_122_;
    _zz_123_[7] = _zz_122_;
    _zz_123_[6] = _zz_122_;
    _zz_123_[5] = _zz_122_;
    _zz_123_[4] = _zz_122_;
    _zz_123_[3] = _zz_122_;
    _zz_123_[2] = _zz_122_;
    _zz_123_[1] = _zz_122_;
    _zz_123_[0] = _zz_122_;
  end

  assign _zz_90_ = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_121_,{{{_zz_282_,_zz_283_},_zz_284_},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_123_,{{{_zz_285_,_zz_286_},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = IBusCachedPlugin_cache_io_mem_cmd_valid;
  always @ (*) begin
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  end

  assign iBus_cmd_payload_size = IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  assign IBusCachedPlugin_s0_tightlyCoupledHit = 1'b0;
  assign _zz_182_ = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && (! IBusCachedPlugin_s0_tightlyCoupledHit));
  assign _zz_185_ = (IBusCachedPlugin_jump_pcLoad_valid || _zz_88_);
  assign _zz_186_ = (32'b00000000000000000000000000000000);
  assign _zz_183_ = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && (! IBusCachedPlugin_s1_tightlyCoupledHit));
  assign _zz_184_ = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign _zz_194_ = (IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_valid && (! IBusCachedPlugin_s2_tightlyCoupledHit));
  assign _zz_195_ = (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready);
  assign _zz_196_ = (CsrPlugin_privilege == (2'b00));
  assign IBusCachedPlugin_rsp_iBusRspOutputHalt = 1'b0;
  assign _zz_92_ = IBusCachedPlugin_rsp_redoFetch;
  assign _zz_93_ = IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_payload;
  assign IBusCachedPlugin_iBusRsp_decodeInput_valid = IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_valid;
  assign IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_ready = IBusCachedPlugin_iBusRsp_decodeInput_ready;
  assign IBusCachedPlugin_iBusRsp_decodeInput_payload_rsp_inst = IBusCachedPlugin_cache_io_cpu_decode_data;
  assign IBusCachedPlugin_iBusRsp_decodeInput_payload_pc = IBusCachedPlugin_iBusRsp_cacheRspArbitration_output_payload;
  assign _zz_187_ = _zz_94_[31];
  assign _zz_188_ = 1'b1;
  assign _zz_189_ = 1'b1;
  assign _zz_190_ = 1'b1;
  assign _zz_191_ = 1'b1;
  assign _zz_192_ = 1'b0;
  assign _zz_193_ = 1'b1;
  assign execute_DBusSimplePlugin_cmdSent = 1'b0;
  assign _zz_80_ = (((dBus_cmd_payload_size == (2'b10)) && (dBus_cmd_payload_address[1 : 0] != (2'b00))) || ((dBus_cmd_payload_size == (2'b01)) && (dBus_cmd_payload_address[0 : 0] != (1'b0))));
  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_ALIGNEMENT_FAULT)) && (! execute_DBusSimplePlugin_cmdSent));
  assign dBus_cmd_payload_wr = execute_INSTRUCTION[5];
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_124_ = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_124_ = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_124_ = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_124_;
  assign _zz_79_ = dBus_cmd_payload_address[1 : 0];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_125_ = (4'b0001);
      end
      2'b01 : begin
        _zz_125_ = (4'b0011);
      end
      default : begin
        _zz_125_ = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_125_ <<< dBus_cmd_payload_address[1 : 0]);
  assign _zz_78_ = dBus_rsp_data;
  assign memory_exception_agregat_payload_code = {1'd0, _zz_219_};
  always @ (*) begin
    memory_exception_agregat_valid = memory_ALIGNEMENT_FAULT;
    if((! ((memory_arbitration_isValid && memory_MEMORY_ENABLE) && 1'b1)))begin
      memory_exception_agregat_valid = 1'b0;
    end
  end

  assign memory_exception_agregat_payload_badAddr = memory_REGFILE_WRITE_DATA;
  always @ (*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_126_ = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_127_[31] = _zz_126_;
    _zz_127_[30] = _zz_126_;
    _zz_127_[29] = _zz_126_;
    _zz_127_[28] = _zz_126_;
    _zz_127_[27] = _zz_126_;
    _zz_127_[26] = _zz_126_;
    _zz_127_[25] = _zz_126_;
    _zz_127_[24] = _zz_126_;
    _zz_127_[23] = _zz_126_;
    _zz_127_[22] = _zz_126_;
    _zz_127_[21] = _zz_126_;
    _zz_127_[20] = _zz_126_;
    _zz_127_[19] = _zz_126_;
    _zz_127_[18] = _zz_126_;
    _zz_127_[17] = _zz_126_;
    _zz_127_[16] = _zz_126_;
    _zz_127_[15] = _zz_126_;
    _zz_127_[14] = _zz_126_;
    _zz_127_[13] = _zz_126_;
    _zz_127_[12] = _zz_126_;
    _zz_127_[11] = _zz_126_;
    _zz_127_[10] = _zz_126_;
    _zz_127_[9] = _zz_126_;
    _zz_127_[8] = _zz_126_;
    _zz_127_[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_128_ = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_129_[31] = _zz_128_;
    _zz_129_[30] = _zz_128_;
    _zz_129_[29] = _zz_128_;
    _zz_129_[28] = _zz_128_;
    _zz_129_[27] = _zz_128_;
    _zz_129_[26] = _zz_128_;
    _zz_129_[25] = _zz_128_;
    _zz_129_[24] = _zz_128_;
    _zz_129_[23] = _zz_128_;
    _zz_129_[22] = _zz_128_;
    _zz_129_[21] = _zz_128_;
    _zz_129_[20] = _zz_128_;
    _zz_129_[19] = _zz_128_;
    _zz_129_[18] = _zz_128_;
    _zz_129_[17] = _zz_128_;
    _zz_129_[16] = _zz_128_;
    _zz_129_[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_207_)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_127_;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_129_;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign _zz_94_ = IBusCachedPlugin_cache_io_cpu_fetch_mmuBus_cmd_virtualAddress;
  assign _zz_131_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001010000)) == (32'b00000000000000000100000001010000));
  assign _zz_132_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_133_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_134_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000110000)) == (32'b00000000000000000000000000010000));
  assign _zz_130_ = {(((decode_INSTRUCTION & _zz_287_) == (32'b00000000000000000000000000001000)) != (1'b0)),{({_zz_288_,{_zz_289_,_zz_290_}} != (3'b000)),{({_zz_291_,_zz_292_} != (2'b00)),{(_zz_293_ != _zz_294_),{_zz_295_,{_zz_296_,_zz_297_}}}}}};
  assign _zz_135_ = _zz_130_[1 : 0];
  assign _zz_76_ = _zz_135_;
  assign _zz_136_ = _zz_130_[3 : 2];
  assign _zz_75_ = _zz_136_;
  assign _zz_137_ = _zz_130_[5 : 4];
  assign _zz_74_ = _zz_137_;
  assign _zz_138_ = _zz_130_[7 : 6];
  assign _zz_73_ = _zz_138_;
  assign _zz_72_ = _zz_220_[0];
  assign _zz_139_ = _zz_130_[10 : 9];
  assign _zz_71_ = _zz_139_;
  assign _zz_70_ = _zz_221_[0];
  assign _zz_69_ = _zz_222_[0];
  assign _zz_68_ = _zz_223_[0];
  assign _zz_67_ = _zz_224_[0];
  assign _zz_66_ = _zz_225_[0];
  assign _zz_140_ = _zz_130_[18 : 17];
  assign _zz_65_ = _zz_140_;
  assign _zz_64_ = _zz_226_[0];
  assign _zz_63_ = _zz_227_[0];
  assign _zz_141_ = _zz_130_[23 : 22];
  assign _zz_62_ = _zz_141_;
  assign _zz_61_ = _zz_228_[0];
  assign _zz_60_ = _zz_229_[0];
  assign _zz_59_ = _zz_230_[0];
  assign execute_RegFilePlugin_srcInstruction = (execute_arbitration_isStuck ? execute_INSTRUCTION : decode_INSTRUCTION);
  assign execute_RegFilePlugin_regFileReadAddress1 = execute_RegFilePlugin_srcInstruction[19 : 15];
  assign execute_RegFilePlugin_regFileReadAddress2 = execute_RegFilePlugin_srcInstruction[24 : 20];
  assign execute_RegFilePlugin_rs1Data = _zz_197_;
  assign execute_RegFilePlugin_rs2Data = _zz_198_;
  assign _zz_58_ = execute_RegFilePlugin_rs1Data;
  assign _zz_57_ = execute_RegFilePlugin_rs2Data;
  assign writeBack_RegFilePlugin_regFileWrite_valid = (_zz_55_ && writeBack_arbitration_isFiring);
  assign writeBack_RegFilePlugin_regFileWrite_payload_address = _zz_54_[11 : 7];
  assign writeBack_RegFilePlugin_regFileWrite_payload_data = _zz_77_;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = execute_SRC1;
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_BITWISE : begin
        _zz_142_ = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_142_ = {31'd0, _zz_231_};
      end
      default : begin
        _zz_142_ = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_52_ = _zz_142_;
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_143_ = execute_RS1;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_143_ = {29'd0, _zz_232_};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_143_ = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
      default : begin
        _zz_143_ = {27'd0, _zz_233_};
      end
    endcase
  end

  assign _zz_50_ = _zz_143_;
  assign _zz_144_ = _zz_234_[11];
  always @ (*) begin
    _zz_145_[19] = _zz_144_;
    _zz_145_[18] = _zz_144_;
    _zz_145_[17] = _zz_144_;
    _zz_145_[16] = _zz_144_;
    _zz_145_[15] = _zz_144_;
    _zz_145_[14] = _zz_144_;
    _zz_145_[13] = _zz_144_;
    _zz_145_[12] = _zz_144_;
    _zz_145_[11] = _zz_144_;
    _zz_145_[10] = _zz_144_;
    _zz_145_[9] = _zz_144_;
    _zz_145_[8] = _zz_144_;
    _zz_145_[7] = _zz_144_;
    _zz_145_[6] = _zz_144_;
    _zz_145_[5] = _zz_144_;
    _zz_145_[4] = _zz_144_;
    _zz_145_[3] = _zz_144_;
    _zz_145_[2] = _zz_144_;
    _zz_145_[1] = _zz_144_;
    _zz_145_[0] = _zz_144_;
  end

  assign _zz_146_ = _zz_235_[11];
  always @ (*) begin
    _zz_147_[19] = _zz_146_;
    _zz_147_[18] = _zz_146_;
    _zz_147_[17] = _zz_146_;
    _zz_147_[16] = _zz_146_;
    _zz_147_[15] = _zz_146_;
    _zz_147_[14] = _zz_146_;
    _zz_147_[13] = _zz_146_;
    _zz_147_[12] = _zz_146_;
    _zz_147_[11] = _zz_146_;
    _zz_147_[10] = _zz_146_;
    _zz_147_[9] = _zz_146_;
    _zz_147_[8] = _zz_146_;
    _zz_147_[7] = _zz_146_;
    _zz_147_[6] = _zz_146_;
    _zz_147_[5] = _zz_146_;
    _zz_147_[4] = _zz_146_;
    _zz_147_[3] = _zz_146_;
    _zz_147_[2] = _zz_146_;
    _zz_147_[1] = _zz_146_;
    _zz_147_[0] = _zz_146_;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_148_ = execute_RS2;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_148_ = {_zz_145_,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_148_ = {_zz_147_,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_148_ = _zz_46_;
      end
    endcase
  end

  assign _zz_48_ = _zz_148_;
  assign execute_SrcPlugin_addSub = _zz_236_;
  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_45_ = execute_SrcPlugin_addSub;
  assign _zz_44_ = execute_SrcPlugin_addSub;
  assign _zz_43_ = execute_SrcPlugin_less;
  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_defaultEncoding_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == (4'b0000));
  always @ (*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : begin
        _zz_149_ = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_149_ = _zz_244_;
      end
    endcase
  end

  assign _zz_40_ = (_zz_91_ && (! decode_IS_FENCEI));
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_150_ = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_150_ == (3'b000))) begin
        _zz_151_ = execute_BranchPlugin_eq;
    end else if((_zz_150_ == (3'b001))) begin
        _zz_151_ = (! execute_BranchPlugin_eq);
    end else if((((_zz_150_ & (3'b101)) == (3'b101)))) begin
        _zz_151_ = (! execute_SRC_LESS);
    end else begin
        _zz_151_ = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_152_ = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_152_ = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_152_ = 1'b1;
      end
      default : begin
        _zz_152_ = _zz_151_;
      end
    endcase
  end

  assign _zz_39_ = _zz_152_;
  assign _zz_153_ = _zz_246_[11];
  always @ (*) begin
    _zz_154_[19] = _zz_153_;
    _zz_154_[18] = _zz_153_;
    _zz_154_[17] = _zz_153_;
    _zz_154_[16] = _zz_153_;
    _zz_154_[15] = _zz_153_;
    _zz_154_[14] = _zz_153_;
    _zz_154_[13] = _zz_153_;
    _zz_154_[12] = _zz_153_;
    _zz_154_[11] = _zz_153_;
    _zz_154_[10] = _zz_153_;
    _zz_154_[9] = _zz_153_;
    _zz_154_[8] = _zz_153_;
    _zz_154_[7] = _zz_153_;
    _zz_154_[6] = _zz_153_;
    _zz_154_[5] = _zz_153_;
    _zz_154_[4] = _zz_153_;
    _zz_154_[3] = _zz_153_;
    _zz_154_[2] = _zz_153_;
    _zz_154_[1] = _zz_153_;
    _zz_154_[0] = _zz_153_;
  end

  assign _zz_155_ = _zz_247_[19];
  always @ (*) begin
    _zz_156_[10] = _zz_155_;
    _zz_156_[9] = _zz_155_;
    _zz_156_[8] = _zz_155_;
    _zz_156_[7] = _zz_155_;
    _zz_156_[6] = _zz_155_;
    _zz_156_[5] = _zz_155_;
    _zz_156_[4] = _zz_155_;
    _zz_156_[3] = _zz_155_;
    _zz_156_[2] = _zz_155_;
    _zz_156_[1] = _zz_155_;
    _zz_156_[0] = _zz_155_;
  end

  assign _zz_157_ = _zz_248_[11];
  always @ (*) begin
    _zz_158_[18] = _zz_157_;
    _zz_158_[17] = _zz_157_;
    _zz_158_[16] = _zz_157_;
    _zz_158_[15] = _zz_157_;
    _zz_158_[14] = _zz_157_;
    _zz_158_[13] = _zz_157_;
    _zz_158_[12] = _zz_157_;
    _zz_158_[11] = _zz_157_;
    _zz_158_[10] = _zz_157_;
    _zz_158_[9] = _zz_157_;
    _zz_158_[8] = _zz_157_;
    _zz_158_[7] = _zz_157_;
    _zz_158_[6] = _zz_157_;
    _zz_158_[5] = _zz_157_;
    _zz_158_[4] = _zz_157_;
    _zz_158_[3] = _zz_157_;
    _zz_158_[2] = _zz_157_;
    _zz_158_[1] = _zz_157_;
    _zz_158_[0] = _zz_157_;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_159_ = (_zz_249_[1] ^ execute_RS1[1]);
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_159_ = _zz_250_[1];
      end
      default : begin
        _zz_159_ = _zz_251_[1];
      end
    endcase
  end

  assign execute_BranchPlugin_missAlignedTarget = (execute_BRANCH_COND_RESULT && _zz_159_);
  assign _zz_37_ = ((execute_PREDICTION_HAD_BRANCHED2 != execute_BRANCH_COND_RESULT) || execute_BranchPlugin_missAlignedTarget);
  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
        execute_BranchPlugin_branch_src2 = {_zz_161_,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
        execute_BranchPlugin_branch_src2 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_163_,{{{_zz_432_,execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_165_,{{{_zz_433_,_zz_434_},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
        if((execute_PREDICTION_HAD_BRANCHED2 && (! execute_BranchPlugin_missAlignedTarget)))begin
          execute_BranchPlugin_branch_src2 = {29'd0, _zz_255_};
        end
      end
    endcase
  end

  assign _zz_160_ = _zz_252_[11];
  always @ (*) begin
    _zz_161_[19] = _zz_160_;
    _zz_161_[18] = _zz_160_;
    _zz_161_[17] = _zz_160_;
    _zz_161_[16] = _zz_160_;
    _zz_161_[15] = _zz_160_;
    _zz_161_[14] = _zz_160_;
    _zz_161_[13] = _zz_160_;
    _zz_161_[12] = _zz_160_;
    _zz_161_[11] = _zz_160_;
    _zz_161_[10] = _zz_160_;
    _zz_161_[9] = _zz_160_;
    _zz_161_[8] = _zz_160_;
    _zz_161_[7] = _zz_160_;
    _zz_161_[6] = _zz_160_;
    _zz_161_[5] = _zz_160_;
    _zz_161_[4] = _zz_160_;
    _zz_161_[3] = _zz_160_;
    _zz_161_[2] = _zz_160_;
    _zz_161_[1] = _zz_160_;
    _zz_161_[0] = _zz_160_;
  end

  assign _zz_162_ = _zz_253_[19];
  always @ (*) begin
    _zz_163_[10] = _zz_162_;
    _zz_163_[9] = _zz_162_;
    _zz_163_[8] = _zz_162_;
    _zz_163_[7] = _zz_162_;
    _zz_163_[6] = _zz_162_;
    _zz_163_[5] = _zz_162_;
    _zz_163_[4] = _zz_162_;
    _zz_163_[3] = _zz_162_;
    _zz_163_[2] = _zz_162_;
    _zz_163_[1] = _zz_162_;
    _zz_163_[0] = _zz_162_;
  end

  assign _zz_164_ = _zz_254_[11];
  always @ (*) begin
    _zz_165_[18] = _zz_164_;
    _zz_165_[17] = _zz_164_;
    _zz_165_[16] = _zz_164_;
    _zz_165_[15] = _zz_164_;
    _zz_165_[14] = _zz_164_;
    _zz_165_[13] = _zz_164_;
    _zz_165_[12] = _zz_164_;
    _zz_165_[11] = _zz_164_;
    _zz_165_[10] = _zz_164_;
    _zz_165_[9] = _zz_164_;
    _zz_165_[8] = _zz_164_;
    _zz_165_[7] = _zz_164_;
    _zz_165_[6] = _zz_164_;
    _zz_165_[5] = _zz_164_;
    _zz_165_[4] = _zz_164_;
    _zz_165_[3] = _zz_164_;
    _zz_165_[2] = _zz_164_;
    _zz_165_[1] = _zz_164_;
    _zz_165_[0] = _zz_164_;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_36_ = {execute_BranchPlugin_branchAdder[31 : 1],(1'b0)};
  assign _zz_95_ = ((execute_arbitration_isValid && (! execute_arbitration_isStuckByOthers)) && execute_BRANCH_DO);
  assign _zz_96_ = execute_BRANCH_CALC;
  always @ (*) begin
    _zz_97_ = (execute_arbitration_isValid && (execute_BRANCH_DO && execute_BRANCH_CALC[1]));
    if(execute_arbitration_isStuckByOthers)begin
      _zz_97_ = 1'b0;
    end
  end

  assign CsrPlugin_misa_base = (2'b01);
  assign CsrPlugin_misa_extensions = (26'b00000000000000000000000000);
  assign CsrPlugin_medeleg = (32'b00000000000000000000000000000000);
  assign CsrPlugin_mideleg = (32'b00000000000000000000000000000000);
  assign _zz_166_ = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_167_ = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_168_ = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  assign CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode = 1'b0;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = (2'b11);
  assign execute_exception_agregat_valid = ({_zz_100_,_zz_97_} != (2'b00));
  assign _zz_169_ = {_zz_100_,_zz_97_};
  assign _zz_170_ = _zz_256_[0];
  assign execute_exception_agregat_payload_code = (_zz_170_ ? (4'b0000) : _zz_101_);
  assign execute_exception_agregat_payload_badAddr = (_zz_170_ ? execute_BRANCH_CALC : (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx));
  assign CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  assign CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  always @ (*) begin
    CsrPlugin_interrupt = 1'b0;
    CsrPlugin_interruptCode = (4'bxxxx);
    if(CsrPlugin_mstatus_MIE)begin
      if(({_zz_168_,{_zz_167_,_zz_166_}} != (3'b000)))begin
        CsrPlugin_interrupt = 1'b1;
      end
      if(_zz_166_)begin
        CsrPlugin_interruptCode = (4'b0111);
      end
      if(_zz_167_)begin
        CsrPlugin_interruptCode = (4'b0011);
      end
      if(_zz_168_)begin
        CsrPlugin_interruptCode = (4'b1011);
      end
    end
    if((! 1'b1))begin
      CsrPlugin_interrupt = 1'b0;
    end
  end

  assign CsrPlugin_interruptTargetPrivilege = (2'b11);
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && 1'b1);
  assign CsrPlugin_lastStageWasWfi = 1'b0;
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ({writeBack_arbitration_isValid,{memory_arbitration_isValid,execute_arbitration_isValid}} != (3'b000))) && IBusCachedPlugin_injector_nextPcCalc_valids_4);
    if(({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != (3'b000)))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException)begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptJump = (CsrPlugin_interrupt && CsrPlugin_pipelineLiberator_done);
  always @ (*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interruptTargetPrivilege;
    if(CsrPlugin_hadException)begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @ (*) begin
    CsrPlugin_trapCause = CsrPlugin_interruptCode;
    if(CsrPlugin_hadException)begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  assign contextSwitching = _zz_98_;
  assign _zz_33_ = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_32_ = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  assign execute_CsrPlugin_blockedBySideEffects = ({writeBack_arbitration_isValid,memory_arbitration_isValid} != (2'b00));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = _zz_176_;
      end
      12'b001100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[12 : 11] = CsrPlugin_mstatus_MPP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mstatus_MPIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mstatus_MIE;
      end
      12'b001101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mepc;
      end
      12'b001100000101 : begin
        if(execute_CSR_WRITE_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mip_MEIP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mip_MTIP;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mip_MSIP;
      end
      12'b001101000011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mtval;
      end
      12'b111111000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 0] = _zz_177_;
      end
      12'b001101000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mscratch;
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
      end
      12'b001101000010 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_mcause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_mcause_exceptionCode;
      end
      default : begin
      end
    endcase
    if((CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(((! execute_arbitration_isValid) || (! execute_IS_CSR)))begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @ (*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)))begin
      if((execute_INSTRUCTION[29 : 28] != CsrPlugin_privilege))begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @ (*) begin
    _zz_100_ = 1'b0;
    _zz_101_ = (4'bxxxx);
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_ECALL)))begin
      _zz_100_ = 1'b1;
      _zz_101_ = (4'b1011);
    end
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_EBREAK)))begin
      _zz_100_ = 1'b1;
      _zz_101_ = (4'b0011);
    end
  end

  assign execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
  assign execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
  assign execute_CsrPlugin_writeEnable = ((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readEnable = ((execute_CsrPlugin_readInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  always @ (*) begin
    case(_zz_209_)
      1'b0 : begin
        execute_CsrPlugin_writeData = execute_SRC1;
      end
      default : begin
        execute_CsrPlugin_writeData = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readData & (~ execute_SRC1)) : (execute_CsrPlugin_readData | execute_SRC1));
      end
    endcase
  end

  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_210_)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign _zz_29_ = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_28_ = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_27_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_26_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_25_ = ($signed(_zz_258_) + $signed(_zz_266_));
  assign writeBack_MulPlugin_result = ($signed(_zz_267_) + $signed(_zz_268_));
  always @ (*) begin
    _zz_171_ = 1'b0;
    _zz_172_ = 1'b0;
    if(_zz_174_)begin
      if((_zz_175_ == execute_INSTRUCTION[19 : 15]))begin
        _zz_171_ = 1'b1;
      end
      if((_zz_175_ == execute_INSTRUCTION[24 : 20]))begin
        _zz_172_ = 1'b1;
      end
    end
    if((writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! 1'b1)))begin
        if((writeBack_INSTRUCTION[11 : 7] == execute_INSTRUCTION[19 : 15]))begin
          _zz_171_ = 1'b1;
        end
        if((writeBack_INSTRUCTION[11 : 7] == execute_INSTRUCTION[24 : 20]))begin
          _zz_172_ = 1'b1;
        end
      end
    end
    if((memory_arbitration_isValid && memory_REGFILE_WRITE_VALID))begin
      if((1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE)))begin
        if((memory_INSTRUCTION[11 : 7] == execute_INSTRUCTION[19 : 15]))begin
          _zz_171_ = 1'b1;
        end
        if((memory_INSTRUCTION[11 : 7] == execute_INSTRUCTION[24 : 20]))begin
          _zz_172_ = 1'b1;
        end
      end
    end
    if((! execute_RS1_USE))begin
      _zz_171_ = 1'b0;
    end
    if((! execute_RS2_USE))begin
      _zz_172_ = 1'b0;
    end
  end

  assign _zz_173_ = (_zz_55_ && writeBack_arbitration_isFiring);
  assign _zz_177_ = (_zz_176_ & externalInterruptArray_regNext);
  assign externalInterrupt = (_zz_177_ != (32'b00000000000000000000000000000000));
  assign _zz_24_ = decode_ALU_CTRL;
  assign _zz_22_ = _zz_74_;
  assign _zz_51_ = decode_to_execute_ALU_CTRL;
  assign _zz_21_ = decode_SHIFT_CTRL;
  assign _zz_19_ = _zz_62_;
  assign _zz_42_ = decode_to_execute_SHIFT_CTRL;
  assign _zz_18_ = decode_BRANCH_CTRL;
  assign _zz_81_ = _zz_75_;
  assign _zz_38_ = decode_to_execute_BRANCH_CTRL;
  assign _zz_16_ = decode_ALU_BITWISE_CTRL;
  assign _zz_14_ = _zz_65_;
  assign _zz_53_ = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_13_ = decode_SRC1_CTRL;
  assign _zz_11_ = _zz_76_;
  assign _zz_49_ = decode_to_execute_SRC1_CTRL;
  assign _zz_10_ = decode_ENV_CTRL;
  assign _zz_7_ = execute_ENV_CTRL;
  assign _zz_5_ = memory_ENV_CTRL;
  assign _zz_8_ = _zz_71_;
  assign _zz_31_ = decode_to_execute_ENV_CTRL;
  assign _zz_30_ = execute_to_memory_ENV_CTRL;
  assign _zz_34_ = memory_to_writeBack_ENV_CTRL;
  assign _zz_3_ = decode_SRC2_CTRL;
  assign _zz_1_ = _zz_73_;
  assign _zz_47_ = decode_to_execute_SRC2_CTRL;
  assign decode_arbitration_isFlushed = ({writeBack_arbitration_flushAll,{memory_arbitration_flushAll,{execute_arbitration_flushAll,decode_arbitration_flushAll}}} != (4'b0000));
  assign execute_arbitration_isFlushed = ({writeBack_arbitration_flushAll,{memory_arbitration_flushAll,execute_arbitration_flushAll}} != (3'b000));
  assign memory_arbitration_isFlushed = ({writeBack_arbitration_flushAll,memory_arbitration_flushAll} != (2'b00));
  assign writeBack_arbitration_isFlushed = (writeBack_arbitration_flushAll != (1'b0));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign iBusWishbone_ADR = {_zz_277_,_zz_178_};
  assign iBusWishbone_CTI = ((_zz_178_ == (3'b111)) ? (3'b111) : (3'b010));
  assign iBusWishbone_BTE = (2'b00);
  assign iBusWishbone_SEL = (4'b1111);
  assign iBusWishbone_WE = 1'b0;
  assign iBusWishbone_DAT_MOSI = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  always @ (*) begin
    iBusWishbone_CYC = 1'b0;
    iBusWishbone_STB = 1'b0;
    if(_zz_205_)begin
      iBusWishbone_CYC = 1'b1;
      iBusWishbone_STB = 1'b1;
    end
  end

  assign iBus_cmd_ready = (iBus_cmd_valid && iBusWishbone_ACK);
  assign iBus_rsp_valid = _zz_179_;
  assign iBus_rsp_payload_data = iBusWishbone_DAT_MISO_regNext;
  assign iBus_rsp_payload_error = 1'b0;
  assign dBus_cmd_halfPipe_valid = dBus_cmd_halfPipe_regs_valid;
  assign dBus_cmd_halfPipe_payload_wr = dBus_cmd_halfPipe_regs_payload_wr;
  assign dBus_cmd_halfPipe_payload_address = dBus_cmd_halfPipe_regs_payload_address;
  assign dBus_cmd_halfPipe_payload_data = dBus_cmd_halfPipe_regs_payload_data;
  assign dBus_cmd_halfPipe_payload_size = dBus_cmd_halfPipe_regs_payload_size;
  assign dBus_cmd_ready = dBus_cmd_halfPipe_regs_ready;
  assign dBusWishbone_ADR = (dBus_cmd_halfPipe_payload_address >>> 2);
  assign dBusWishbone_CTI = (3'b000);
  assign dBusWishbone_BTE = (2'b00);
  always @ (*) begin
    case(dBus_cmd_halfPipe_payload_size)
      2'b00 : begin
        _zz_180_ = (4'b0001);
      end
      2'b01 : begin
        _zz_180_ = (4'b0011);
      end
      default : begin
        _zz_180_ = (4'b1111);
      end
    endcase
  end

  always @ (*) begin
    dBusWishbone_SEL = _zz_278_[3:0];
    if((! dBus_cmd_halfPipe_payload_wr))begin
      dBusWishbone_SEL = (4'b1111);
    end
  end

  assign dBusWishbone_WE = dBus_cmd_halfPipe_payload_wr;
  assign dBusWishbone_DAT_MOSI = dBus_cmd_halfPipe_payload_data;
  assign dBus_cmd_halfPipe_ready = (dBus_cmd_halfPipe_valid && dBusWishbone_ACK);
  assign dBusWishbone_CYC = dBus_cmd_halfPipe_valid;
  assign dBusWishbone_STB = dBus_cmd_halfPipe_valid;
  assign dBus_rsp_ready = ((dBus_cmd_halfPipe_valid && (! dBusWishbone_WE)) && dBusWishbone_ACK);
  assign dBus_rsp_data = dBusWishbone_DAT_MISO;
  assign dBus_rsp_error = 1'b0;
  always @ (posedge clk) begin
    if(reset) begin
      CsrPlugin_privilege <= (2'b11);
      IBusCachedPlugin_fetchPc_pcReg <= externalResetVector;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      _zz_108_ <= 1'b0;
      _zz_114_ <= 1'b0;
      _zz_116_ <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      execute_LightShifterPlugin_isActive <= 1'b0;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= (2'b11);
      CsrPlugin_mip_MEIP <= 1'b0;
      CsrPlugin_mip_MTIP <= 1'b0;
      CsrPlugin_mip_MSIP <= 1'b0;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      _zz_174_ <= 1'b0;
      _zz_176_ <= (32'b00000000000000000000000000000000);
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_178_ <= (3'b000);
      _zz_179_ <= 1'b0;
      dBus_cmd_halfPipe_regs_valid <= 1'b0;
      dBus_cmd_halfPipe_regs_ready <= 1'b1;
    end else begin
      if(IBusCachedPlugin_fetchPc_propagatePc)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusCachedPlugin_jump_pcLoad_valid)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(_zz_204_)begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_samplePcNext)begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      _zz_108_ <= 1'b1;
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        _zz_114_ <= 1'b0;
      end
      if(_zz_112_)begin
        _zz_114_ <= IBusCachedPlugin_iBusRsp_stages_0_output_valid;
      end
      if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
        _zz_116_ <= IBusCachedPlugin_iBusRsp_stages_1_output_valid;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        _zz_116_ <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_stages_1_input_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready)))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= IBusCachedPlugin_injector_nextPcCalc_valids_3;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b1;
      end
      if((IBusCachedPlugin_jump_pcLoad_valid || _zz_88_))begin
        IBusCachedPlugin_injector_decodeRemoved <= 1'b0;
      end
      if(_zz_200_)begin
        if(_zz_201_)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      CsrPlugin_mip_MEIP <= externalInterrupt;
      CsrPlugin_mip_MTIP <= timerInterrupt;
      if((! execute_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if((! memory_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if((! writeBack_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(_zz_202_)begin
        CsrPlugin_privilege <= CsrPlugin_targetPrivilege;
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(_zz_203_)begin
        case(_zz_208_)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPP <= (2'b00);
            CsrPlugin_mstatus_MPIE <= 1'b1;
            CsrPlugin_privilege <= CsrPlugin_mstatus_MPP;
          end
          default : begin
          end
        endcase
      end
      _zz_174_ <= _zz_173_;
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(execute_CsrPlugin_csrAddress)
        12'b101111000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            _zz_176_ <= execute_CsrPlugin_writeData[31 : 0];
          end
        end
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_271_[0];
            CsrPlugin_mstatus_MIE <= _zz_272_[0];
          end
        end
        12'b001101000001 : begin
        end
        12'b001100000101 : begin
        end
        12'b001101000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mip_MSIP <= _zz_273_[0];
          end
        end
        12'b001101000011 : begin
        end
        12'b111111000000 : begin
        end
        12'b001101000000 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_274_[0];
            CsrPlugin_mie_MTIE <= _zz_275_[0];
            CsrPlugin_mie_MSIE <= _zz_276_[0];
          end
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
      if(_zz_205_)begin
        if(iBusWishbone_ACK)begin
          _zz_178_ <= (_zz_178_ + (3'b001));
        end
      end
      _zz_179_ <= (iBusWishbone_CYC && iBusWishbone_ACK);
      if(_zz_206_)begin
        dBus_cmd_halfPipe_regs_valid <= dBus_cmd_valid;
        dBus_cmd_halfPipe_regs_ready <= (! dBus_cmd_valid);
      end else begin
        dBus_cmd_halfPipe_regs_valid <= (! dBus_cmd_halfPipe_ready);
        dBus_cmd_halfPipe_regs_ready <= dBus_cmd_halfPipe_ready;
      end
    end
  end

  always @ (posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_1_output_ready)begin
      _zz_117_ <= IBusCachedPlugin_iBusRsp_stages_1_output_payload;
    end
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready)begin
      IBusCachedPlugin_s1_tightlyCoupledHit <= IBusCachedPlugin_s0_tightlyCoupledHit;
    end
    if(IBusCachedPlugin_iBusRsp_cacheRspArbitration_input_ready)begin
      IBusCachedPlugin_s2_tightlyCoupledHit <= IBusCachedPlugin_s1_tightlyCoupledHit;
    end
    if(!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if(!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_INSTRUCTION[5])) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow writeback stage stall when read happend");
    end
    if(_zz_200_)begin
      if(_zz_201_)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - (5'b00001));
      end
    end
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    end
    if(execute_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= execute_exception_agregat_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= execute_exception_agregat_payload_badAddr;
    end
    if(memory_exception_agregat_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= memory_exception_agregat_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= memory_exception_agregat_payload_badAddr;
    end
    if((CsrPlugin_exception || CsrPlugin_interruptJump))begin
      case(CsrPlugin_privilege)
        2'b11 : begin
          CsrPlugin_mepc <= writeBack_PC;
        end
        default : begin
        end
      endcase
    end
    if(_zz_202_)begin
      case(CsrPlugin_targetPrivilege)
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
        end
        default : begin
        end
      endcase
    end
    if(_zz_173_)begin
      _zz_175_ <= _zz_54_[11 : 7];
    end
    externalInterruptArray_regNext <= externalInterruptArray;
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_83_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= _zz_82_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= memory_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_23_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_20_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FLUSH_ALL <= decode_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FLUSH_ALL <= execute_FLUSH_ALL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= _zz_35_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_FENCEI <= decode_IS_FENCEI;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= _zz_46_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2_USE <= decode_RS2_USE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_17_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_41_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= memory_REGFILE_WRITE_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_15_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_12_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_9_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ENV_CTRL <= _zz_6_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_ENV_CTRL <= _zz_4_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ALIGNEMENT_FAULT <= execute_ALIGNEMENT_FAULT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_2_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1_USE <= decode_RS1_USE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b101111000000 : begin
      end
      12'b001100000000 : begin
      end
      12'b001101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001100000101 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtvec_base <= execute_CsrPlugin_writeData[31 : 2];
          CsrPlugin_mtvec_mode <= execute_CsrPlugin_writeData[1 : 0];
        end
      end
      12'b001101000100 : begin
      end
      12'b001101000011 : begin
      end
      12'b111111000000 : begin
      end
      12'b001101000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mscratch <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001100000100 : begin
      end
      12'b001101000010 : begin
      end
      default : begin
      end
    endcase
    iBusWishbone_DAT_MISO_regNext <= iBusWishbone_DAT_MISO;
    if(_zz_206_)begin
      dBus_cmd_halfPipe_regs_payload_wr <= dBus_cmd_payload_wr;
      dBus_cmd_halfPipe_regs_payload_address <= dBus_cmd_payload_address;
      dBus_cmd_halfPipe_regs_payload_data <= dBus_cmd_payload_data;
      dBus_cmd_halfPipe_regs_payload_size <= dBus_cmd_payload_size;
    end
  end

endmodule


module MulInfer (
      input   [31:0] inpA,
      input   [31:0] inpB,
      output  [31:0] out,
      output  i_done,
      input   a_signed,
      input   b_signed,
      input   clk,
      input   mul_type,
      input   reset);

  wire execute_MulPlugin_aSigned;
  wire execute_MulPlugin_bSigned;
  reg [33:0] execute_to_memory_MUL_HL;
  reg is_running = 1'b0;
  reg done = 1'b0;
  assign i_done = done;

  wire [31:0] execute_MulPlugin_a;
  wire [31:0] execute_MulPlugin_b;
  wire [15:0] execute_MulPlugin_aULow;
  wire [15:0] execute_MulPlugin_bULow;
  wire [16:0] execute_MulPlugin_aSLow;
  wire [16:0] execute_MulPlugin_bSLow;
  wire [16:0] execute_MulPlugin_aHigh;
  wire [16:0] execute_MulPlugin_bHigh;
  wire [65:0] writeBack_MulPlugin_result;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg [31:0] execute_to_memory_MUL_LL;
  reg [33:0] execute_to_memory_MUL_LH;
  wire [31:0] execute_MUL_LL;
  wire [33:0] execute_MUL_LH;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  wire [33:0] execute_MUL_HL;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  wire [51:0] memory_MUL_LOW;
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
  reg [31:0] out_result;
  assign out = out_result;
  wire _zz_171_;
  wire _zz_172_;

  assign execute_MulPlugin_a = inpA;
  assign execute_MulPlugin_b = inpB;
  assign execute_MulPlugin_aSigned = a_signed;
  assign execute_MulPlugin_bSigned = b_signed;

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
  assign writeBack_MulPlugin_result = ($signed(_zz_267_) + $signed(_zz_268_));
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign memory_MUL_LOW = _zz_25_;
  assign execute_MUL_HH = _zz_26_;
  assign execute_MUL_HL = _zz_27_;
  assign execute_MUL_LH = _zz_28_;
  assign execute_MUL_LL = _zz_29_;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  wire memory_arbitration_isStuck;
  wire writeBack_arbitration_isStuck;
  wire execute_arbitration_isStuck;

  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;

  assign memory_arbitration_isStuck = 1'b0;
  assign writeBack_arbitration_isStuck = 1'b0;
  assign execute_arbitration_isStuck = 1'b0;
  assign decode_IS_MUL = reset;

  always @ (posedge clk) begin

    if (reset) begin
      is_running <= 1;
      done <= 0;
    end else if (is_running && ~memory_to_writeBack_IS_MUL) begin
      is_running <= 0;
      done <= 1;
    end else begin
      done <= 0;
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
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end

    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end

    if (mul_type) begin
      out_result <= _zz_270_;
    end else begin
      out_result <= _zz_269_;
    end
  end
endmodule

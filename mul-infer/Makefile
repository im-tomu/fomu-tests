PACKAGE   ?= MulInfer
TOP       ?= $(PACKAGE)

GIT_VERSION := $(shell git describe --tags)

# Default programs
NEXTPNR   ?= nextpnr-ice40
YOSYS     ?= yosys
ICEPACK   ?= icepack

PCF_PATH ?= ../pcf

# Add Windows and Unix support
RM         = rm -rf
COPY       = cp -a
PATH_SEP   = /
ifeq ($(OS),Windows_NT)
COPY       = copy
RM         = del
PATH_SEP   = \\
endif

FOMU_REV  ?= evt3
ifeq ($(FOMU_REV),evt3)
PCF       ?= $(PCF_PATH)/fomu-evt3.pcf
PKG       ?= sg48
PNRFLAGS  ?= --up5k --package $(PKG)
else
ifeq ($(FOMU_REV),evt2)
PCF       ?= $(PCF_PATH)/fomu-evt2.pcf
PKG       ?= sg48
PNRFLAGS  ?= --up5k --package $(PKG)
else
$(error Unrecognized FOMU_REV value. must be "evt2" or "evt3")
endif
endif

BUILD_DIR  = .build
VSOURCES   = $(wildcard *.v)
QUIET      = @

ALL        = all
TARGET     = $(PACKAGE).bin
CLEAN      = clean

$(ALL): $(TARGET)

test: MulInfer.vcd

MulInfer.vcd: MulInfer_tb.v MulInfer.v
	iverilog -o MulInfer.vvp .\MulInfer_tb.v .\MulInfer.v
	vvp ./MulInfer.vvp

$(BUILD_DIR)/$(PACKAGE).json: $(VSOURCES) | $(BUILD_DIR)
	$(QUIET) echo " SYNTH    $@"
	$(QUIET) $(YOSYS) -p 'synth_ice40 -top $(TOP) -json $@ -dsp -relut' $(PACKAGE).v

$(BUILD_DIR)/$(PACKAGE).asc: $(BUILD_DIR)/$(PACKAGE).json $(PCF)
	$(QUIET) echo " PNR      $@"
	$(QUIET) $(NEXTPNR) $(PNRFLAGS) --json $(BUILD_DIR)/$(PACKAGE).json --pcf $(PCF) --pcf-allow-unconstrained --asc $@

$(TARGET): $(BUILD_DIR)/$(PACKAGE).asc
	$(QUIET) echo " PACK     $@"
	$(QUIET) $(ICEPACK) $(BUILD_DIR)/$(PACKAGE).asc $@

$(BUILD_DIR):
	$(QUIET) mkdir $(BUILD_DIR)

.PHONY: clean test

clean:
	$(QUIET) echo "  RM      $(subst /,$(PATH_SEP),$(wildcard $(BUILD_DIR)/*.json))"
	-$(QUIET) $(RM) $(subst /,$(PATH_SEP),$(wildcard $(BUILD_DIR)/*.json))
	$(QUIET) echo "  RM      $(subst /,$(PATH_SEP),$(wildcard $(BUILD_DIR)/*.asc))"
	-$(QUIET) $(RM) $(subst /,$(PATH_SEP),$(wildcard $(BUILD_DIR)/*.asc))
	$(QUIET) echo "  RM      $(TARGET) $(PACKAGE).bin"
	-$(QUIET) $(RM) $(TARGET) $(PACKAGE).bin

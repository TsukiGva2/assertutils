CC=gcc

CFLAGS=-O3 -I./src/ -std=c11
SHARED_CFLAGS=-fPIC

COPY=cp

LIB := lib

LIBS=-L./$(LIB)/
EXAMPLE_LIBS := -lassertutils
LDFLAGS=

WFLAGS := -Wall -Wextra -pedantic

SOFLAGS=-rdynamic -shared -Lstatic

OUT := libassertutils.so

CC_ECHO_STR := "CC"
LD_ECHO_STR := "LD"

COPY_ECHO_STR := "COPY"
MKDIR_ECHO_STR := "MD"

# no color support
#CC_ECHO_FMT := $(CC_ECHO_STR)
CC_ECHO_FMT := "\033[32;1m" $(CC_ECHO_STR) "\033[0m"

#LD_ECHO_FMT := $(LD_ECHO_STR)
LD_ECHO_FMT := "\033[33;1m" $(LD_ECHO_STR) "\033[0m"

#COPY_ECHO_FMT := $(COPY_ECHO_STR)
COPY_ECHO_FMT := "\033[36;1m" $(COPY_ECHO_STR) "\033[0m"

#MKDIR_ECHO_FMT := $(MKDIR_ECHO_STR)
MKDIR_ECHO_FMT := "\033[31;1m" $(MKDIR_ECHO_STR) "\033[0m"

# why doesn't this work in some systems?
#ECHO_FLAGS := -e
ECHO_FLAGS=

SRC := src
OBJ := obj
INC := include
BIN := bin

DISTDIR?=/usr/local

FILES := $(shell find src/ -name "*.c")
FILENAMES := $(basename $(notdir $(FILES)))
OBJS := $(patsubst %,$(OBJ)/%.o,$(FILENAMES))

#HEADERS := $(wildcard src/*.h)
HEADERS := $(shell find $(SRC)/ -name "*.h")
INCLUDE := $(patsubst src/%,$(INC)/%,$(HEADERS))

HEADER_DIRS := $(sort $(dir $(INCLUDE)))

#INCLUDE := $(addprefix $(INC)/,$(SUBHEADERS))

DISTINC := $(DISTDIR)/$(INC)/$(basename $(OUT))
DISTLIB := $(DISTDIR)/$(LIB)/$(basename $(OUT))

INSTALLED_INC := $(patsubst %,$(DISTINC)/%,$(notdir $(HEADERS)))
INSTALLED_LIB := $(DISTLIB)/$(OUT)

DISTDIRS := $(DISTINC) $(DISTLIB)

LOCALDIRS := $(INC) $(LIB) $(OBJ) $(BIN)

EXAMPLE := examples
EXAMPLES := $(wildcard $(EXAMPLE)/*.c)

.PHONY: all
all: $(LOCALDIRS) $(OUT) $(INCLUDE)

.PHONY: install
install: $(LOCALDIRS) $(DISTDIRS) $(INSTALLED_LIB) $(INSTALLED_INC)

.PHONY: example
example: all $(EXAMPLES)

$(EXAMPLES): $(OUT)
	@echo $(ECHO_FLAGS) $(CC_ECHO_FMT) "   " $@;
	@$(CC) $@ -o $(BIN)/$(notdir $(basename $@)) $(CFLAGS) $(LIBS) $(EXAMPLE_LIBS)

$(LOCALDIRS):
	@echo $(ECHO_FLAGS) $(MKDIR_ECHO_FMT) "   " $@
	@mkdir -p $@

$(DISTLIB):
	@echo $(ECHO_FLAGS) $(MKDIR_ECHO_FMT) "   " $(DISTLIB)
	@mkdir -p $(DISTLIB)

$(DISTINC):
	@echo $(ECHO_FLAGS) $(MKDIR_ECHO_FMT) "   " $(DISTINC)
	@mkdir -p $(DISTINC)

$(INSTALLED_INC): $(INCLUDE)
	@echo $(ECHO_FLAGS) $(COPY_ECHO_FMT) "    ./$(INC) to $(DISTINC)"
	@$(COPY) -r $(INC)/* $(DISTINC)

$(INSTALLED_LIB): $(OUT)
	@echo $(ECHO_FLAGS) $(COPY_ECHO_FMT) "   " $(LIB)/$<
	@$(COPY) $(LIB)/$< $(DISTLIB)

%.so: $(OBJS)
	@echo $(ECHO_FLAGS) $(LD_ECHO_FMT) "   " $(notdir $+);
	@$(CC) -o $(LIB)/$@ $+ $(SOFLAGS) $(LIBS) $(LDFLAGS)

$(OBJ)/%.o: $(CFILES)
	@echo $(ECHO_FLAGS) $(CC_ECHO_FMT) "   " $(shell find src/ -name "$*.c");
	@$(CC) $(shell find src/ -name "$*.c") $(CFLAGS) $(WFLAGS) $(SHARED_CFLAGS) -c -o $@

$(INCLUDE): $(HEADER_DIRS) $(HEADERS)
	@echo $(ECHO_FLAGS) $(COPY_ECHO_FMT) "   " $(shell find src/ -name "$(*F).h") " to $(dir $@)"
	@$(COPY) $(shell find src/ -name "$(*F).h") $@

$(HEADER_DIRS):
	@echo $(ECHO_FLAGS) $(MKDIR_ECHO_FMT) "   " $(dir $@)
	@mkdir -p $@

clean:
	rm -rf $(LOCALDIRS)


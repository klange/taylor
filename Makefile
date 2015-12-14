# Taylor - Swift on bare metal
include util/util.mk

ARCH=i686
TARGET=${ARCH}-pc-none-elf

SWIFTC = swiftc
CC = clang-3.8

SWIFTFLAGS = -emit-ir
CFLAGS = --target=${TARGET} -ffreestanding -Wno-override-module

YASM = yasm -f elf

LD = ld


OBJS  = $(patsubst %.c,%.o,$(wildcard src/*.c))
OBJS += $(patsubst %.c,%.o,$(wildcard src/*/*.c))
OBJS += $(patsubst %.s,%.o,$(wildcard src/*.s))
OBJS += $(patsubst %.swift,%.o,$(wildcard src/*.swift))
OBJS += $(patsubst %.swift,%.o,$(wildcard src/*/*.swift))

all: taylor-kernel

taylor-kernel: ${OBJS}
	@${BEG} "LD" $@
	@${LD} -m elf_i386 -T link.ld -o $@ ${OBJS}
	@${END} "LD" $@

%.o: %.swift
	@${BEG} "SWIFT" $<
	@$(SWIFTC) $(SWIFTFLAGS) $< -o ${@:.o=}.ll
	@$(CC) $(CFLAGS) -c ${@:.o=}.ll -o $@
	@${END} "SWIFT" $<

%.o: %.s
	@${BEG} "YASM" $<
	@${YASM} -o $@ $<
	@${END} "YASM" $<

.PHONY: clean

clean:
	@-rm src/*.o
	@-rm src/*.ll
	@-rm taylor-kernel

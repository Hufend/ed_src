SUFFIX = .out

.PHONY: init ed_x86_mbr_qemu

all: init build/ed.c$(SUFFIX) build/ed_x86 build/ed_x86_mbr.img
	$(info Done!)

# Initialization
init:
	@mkdir -p build

# C
build/ed.c$(SUFFIX): src/ed.c
	$(info Compiling $< to $@ ...)
	@$(CC) -o $@ $<

# x86 Assembly
# Only support Unix or Unix-like
build/ed_x86: src/ed_x86.asm
	$(info Assembling $< to $@.o ...)
	@nasm -felf64 -o $@.o $<
	$(info Linking $@.o to $@ ...)
	@$(LD) -melf_x86_64 -o $@ $@.o

# x86 MBR
build/ed_x86_mbr.img: src/ed_x86_mbr.asm
	$(info Assembling $< to $@.bin ...)
	@nasm -fbin -o $@.bin $<
	$(info Making the system image ...)
	@dd if=/dev/zero of=$@ bs=512 count=1
	@dd if=$@.bin of=$@ bs=512 count=1 conv=notrunc

ed_x86_mbr_qemu:
	$(info Lauching QEMU ...)
	@qemu-system-x86_64 -m 1024 build/ed_x86_mbr.img

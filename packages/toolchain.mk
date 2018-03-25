export BASEDIR := $(shell readlink -f .)
export PATH := $(shell readlink -f ..)/toolchain/bin:$(PATH)
export SYSROOT := $(shell readlink -f ..)/sysroot
STAGE := $(BASEDIR)/root
TOOLCHAIN := $(shell readlink -f ..)/toolchain/bin/arm-linux-gnueabihf-

ARCH_CFLAGS := -pipe -march=armv6 -marm -mthumb-interwork -mfpu=vfp -mtune=cortex-a7 -mabi=aapcs-linux -mfloat-abi=hard

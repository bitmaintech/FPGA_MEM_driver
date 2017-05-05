# Makefile for bitmain_asic_spi_drv

export CROSS_COMPILE=$(TOOLCHAIN_DIR)/arm-xilinx-linux-gnueabi-

TARGET = fpga_mem_driver

OBJECT = fpga_mem.o

ifneq ($(KERNELRELEASE),)

#kbuild syntax.

#obj-$(CONFIG_BITMAIN_ASIC_SPI) += $(TARGET).o
obj-m = $(TARGET).o

$(TARGET)-objs := $(OBJECT)

else

PWD := $(shell pwd)


KDIR := $(KERNEL_DIR)

all : modules

modules:
	$(MAKE) -C $(KDIR) M=$(PWD) ARCH=arm modules
	sudo cp fpga_mem_driver.ko /home/lzq/work/Zynq7010/rootfs/angstrom_rootfs/angstrom_rootfs/lib/modules
clean:
	rm -rf .*.cmd *.o *.mod.c *.ko .tmp_versions Module.markers modules.order Module.symvers
endif


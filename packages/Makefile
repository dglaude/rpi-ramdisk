include ../.config

all: toolchain sysroot $(PACKAGES)

rygel: gstreamer

qmlrss: qt

toolchain:
	wget -N https://releases.linaro.org/components/toolchain/binaries/6.3-2017.05/arm-linux-gnueabihf/gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf.tar.xz
	tar -xf gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf.tar.xz
	mv gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf/ toolchain/

sysroot.conf: sysroot.part $(foreach DIR,$(PACKAGES),$(DIR)/sysroot.part)
	cat sysroot.part > sysroot.conf
	for dir in $(PACKAGES); do cat $$dir/sysroot.part >> sysroot.conf; done

sysroot: sysroot.conf ../.config
	rm -rf --one-file-system sysroot/
	mkdir -p sysroot/etc/apt/trusted.gpg.d/
	gpg --export 82B129927FA3303E > sysroot/etc/apt/trusted.gpg.d/raspberrypi-archive-keyring.gpg
	gpg --export 9165938D90FDDD2E > sysroot/etc/apt/trusted.gpg.d/raspbian-archive-keyring.gpg
	http_proxy=$APT_HTTP_PROXY /usr/sbin/multistrap -d sysroot/ -f sysroot.conf
	./relativelinks.py sysroot/
	# work around for libtool badness
	mkdir -p sysroot/opt
	cd sysroot/opt && for dir in $(PACKAGES); do ln -s ../../$$dir/root/opt/$$dir $$dir; done
	touch sysroot

$(PACKAGES): toolchain sysroot
	$(MAKE) -C $@

clean:
	for dir in $(PACKAGES); do $(MAKE) -C $$dir clean; done
	rm -rf sysroot/ toolchain/ sysroot.conf

.PHONY: $(PACKAGES) clean


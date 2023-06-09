NAME="qemu"
DESC="Full virtualization solution for Linux on x86 hardware containing virtualization extensions (Intel VT or AMD-V)"
VERSION="7.2.0"
SOURCE="https://download.qemu.org/qemu-${VERSION}.tar.xz"
CHECKSUM="7630d6a9eba7ab2bcb9979d6d24c2697"
DEPS="glib alsa-lib libslirp sdl2"
FLAGS="test"
NOTES="Remember to enable KVM options in the kernel for the best virtualization experience"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	if [ $(uname -m) = i686 ]; then
	   QEMU_ARCH=i386-softmmu
	else
	   QEMU_ARCH=x86_64-softmmu
	fi


	mkdir -vp build
	cd        build

	../configure --prefix=/usr               \
				 --sysconfdir=/etc           \
				 --localstatedir=/var        \
				 --target-list=$QEMU_ARCH    \
				 --audio-drv-list=alsa       \
				 --disable-pa                \
				 --docdir=/usr/share/doc/qemu-${VERSION}

	unset QEMU_ARCH

	make
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Create a udev rule that sets the correct permissions for the KVM devices
	mkdir -p $FAKEROOT/$NAME/usr/lib/udev/rules.d
	cat > $FAKEROOT/$NAME/usr/lib/udev/rules.d/65-kvm.rules << "EOF"
KERNEL=="kvm", GROUP="kvm", MODE="0660"
EOF

	# Change the permissions and ownership of the network bridge script
	chgrp kvm  $FAKEROOT/$NAME/usr/libexec/qemu-bridge-helper
	chmod 4750 $FAKEROOT/$NAME/usr/libexec/qemu-bridge-helper

	# Create a symlink for the architecture of this system
	ln -srv qemu-system-`uname -m` $FAKEROOT/$NAME/usr/bin/qemu
}

_test()
{
	ninja test
}

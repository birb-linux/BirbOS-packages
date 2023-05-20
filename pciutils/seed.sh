NAME="pciutils"
DESC="A set of programs for listing PCI devices, inspecting their status and setting their configuration registers"
VERSION="3.9.0"
SOURCE="https://mj.ucw.cz/download/linux/pci/pciutils-${VERSION}.tar.gz"
CHECKSUM="357496ae1652aac66cad0d2de2d831d0"
DEPS="curl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make PREFIX=$FAKEROOT/$NAME/usr \
		 SHAREDIR=/usr/share/hwdata \
		 SHARED=yes
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr \
		 SHAREDIR=/usr/share/hwdata \
		 SHARED=yes                 \
		 install install-lib

	chmod -v 755 $FAKEROOT/$NAME/usr/lib/libpci.so
}

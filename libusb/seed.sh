NAME="libusb"
DESC="Library used by some applications for USB device access"
VERSION="1.0.26"
SOURCE="https://github.com/libusb/libusb/releases/download/v${VERSION}/libusb-${VERSION}.tar.bz2"
CHECKSUM="9c75660dfe1d659387c37b28c91e3160"
DEPS=""
FLAGS=""

_setup()
{
	kernel_check "CONFIG_USB_SUPPORT CONFIG_USB"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

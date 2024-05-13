# shellcheck disable=SC2034
NAME="usbutils"
DESC="Utilities for displaying information about USB buses in the system and the devices connected to them"
VERSION="017"
SOURCE="https://kernel.org/pub/linux/utils/usb/usbutils/usbutils-${VERSION}.tar.xz"
CHECKSUM="8ff21441faf2e8128e4810b3d6e49059"
DEPS="libusb wget"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	./configure --prefix=/usr --datadir=/usr/share/hwdata

	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install

	# Download and install the hwdata file
	install -dm755 "$FAKEROOT/$NAME/usr/share/hwdata/"
	wget http://www.linux-usb.org/usb.ids -O "$FAKEROOT/$NAME/usr/share/hwdata/usb.ids"
}

NAME="xf86-input-wacom"
DESC="X.Org X11 driver and SDK for Wacom and Wacom-like tablets"
VERSION="1.2.0"
SOURCE="https://github.com/linuxwacom/xf86-input-wacom/releases/download/xf86-input-wacom-${VERSION}/xf86-input-wacom-${VERSION}.tar.bz2"
CHECKSUM="9de66dbfa7dbb3897708d35776da0108"
DEPS="xorg-server"
FLAGS=""

_setup()
{
	kernel_check "CONFIG_HID_WACOM CONFIG_USB_HID CONFIG_HID CONFIG_USB"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --with-systemd-unit-dir=no
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

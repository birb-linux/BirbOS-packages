NAME="xf86-input-evdev"
DESC="Generic Linux input driver for the Xorg X server"
VERSION="2.10.6"
SOURCE="https://www.x.org/pub/individual/driver/xf86-input-evdev-${VERSION}.tar.bz2"
CHECKSUM="e8bd1edc6751f92e425cae7eba3c61eb"
DEPS="libevdev mtdev xorg-server"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${MAKEOPTS}
}

_install()
{
	make install
}

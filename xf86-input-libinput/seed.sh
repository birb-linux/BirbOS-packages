NAME="xf86-input-libinput"
DESC="Thin wrapper around libinput and allows for libinput to be used for input devices in X"
VERSION="1.2.1"
SOURCE="https://www.x.org/pub/individual/driver/xf86-input-libinput-${VERSION}.tar.xz"
CHECKSUM="c6e942a1d639ebe2621905cc84eb26b9"
DEPS="libinput xorg-server"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}

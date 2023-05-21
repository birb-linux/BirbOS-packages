NAME="setxkbmap"
DESC="Set the keyboard using the X Keyboard Extension"
VERSION="1.3.3"
SOURCE="https://www.x.org/archive//individual/app/setxkbmap-${VERSION}.tar.xz"
CHECKSUM="2f72c7170cdbadc8ef786b2f9cfd4a69"
DEPS="libpng mesa xbitmaps xcb-util"
FLAGS=""

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

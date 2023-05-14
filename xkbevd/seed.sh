NAME="xkbevd"
DESC="XKB event daemon"
VERSION="1.1.5"
SOURCE="https://www.x.org/archive//individual/app/xkbevd-${VERSION}.tar.xz"
CHECKSUM="05ce1abd8533a400572784b1186a44d0"
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
	make -j${MAKEOPTS}
}

_install()
{
	make install
}

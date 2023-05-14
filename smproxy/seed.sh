NAME="smproxy"
DESC="Session Manager Proxy"
VERSION="1.0.7"
SOURCE="https://www.x.org/archive//individual/app/smproxy-${VERSION}.tar.xz"
CHECKSUM="9f7a4305f0e79d5a46c3c7d02df9437d"
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

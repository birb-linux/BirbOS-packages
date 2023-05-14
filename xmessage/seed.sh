NAME="xmessage"
DESC="Display a message or query in a window (X-based /bin/echo)"
VERSION="1.0.6"
SOURCE="https://www.x.org/archive//individual/app/xmessage-${VERSION}.tar.xz"
CHECKSUM="f33841b022db1648c891fdc094014aee"
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

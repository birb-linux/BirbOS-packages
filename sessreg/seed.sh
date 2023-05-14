NAME="sessreg"
DESC="Manage utmp/wtmp entries for non-init clients"
VERSION="1.1.3"
SOURCE="https://www.x.org/archive//individual/app/sessreg-${VERSION}.tar.xz"
CHECKSUM="05423bb42a006a6eb2c36ba10393de23"
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

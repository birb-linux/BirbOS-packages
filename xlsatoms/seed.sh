NAME="xlsatoms"
DESC="List interned	atoms defined on server"
VERSION="1.1.4"
SOURCE="https://www.x.org/archive//individual/app/xlsatoms-${VERSION}.tar.xz"
CHECKSUM="da5b7a39702841281e1d86b7349a03ba"
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

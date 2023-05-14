NAME="xmodmap"
DESC="Utility for modifying keymaps and pointer button mappings in X"
VERSION="1.0.11"
SOURCE="https://www.x.org/archive//individual/app/xmodmap-${VERSION}.tar.xz"
CHECKSUM="0d66e07595ea083871048c4b805d8b13"
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

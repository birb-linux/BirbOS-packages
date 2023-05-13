NAME="xbitmaps"
DESC="Bitmap images used by multiple Xorg applications"
VERSION="1.1.2"
SOURCE="https://www.x.org/pub/individual/data/xbitmaps-${VERSION}.tar.bz2"
CHECKSUM="cedeef095918aca86da79a2934e03daf"
DEPS="util-macros"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
}

_install()
{
	make install
}

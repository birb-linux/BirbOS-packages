NAME="libxt"
DESC="X Toolkit Intrinsics library"
VERSION="1.2.1"
SOURCE="https://www.x.org/archive//individual/lib/libXt-${VERSION}.tar.bz2"
CHECKSUM="b122ff9a7ec70c94dbbfd814899fffa5"
DEPS="fontconfig libxcb elogind libx11 libsm libice"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXt-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION \
		--with-appdefaultdir=/etc/X11/app-defaults

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

NAME="xtst"
DESC="Xlib-based library for XTEST & RECORD extensions"
VERSION="1.2.4"
SOURCE="https://gitlab.freedesktop.org/xorg/lib/libxtst/-/archive/libXtst-${VERSION}/libxtst-libXtst-${VERSION}.tar.gz"
CHECKSUM="b1b77a3cee2775d2033cfbd32d349469"
DEPS="libx11 libxext xorgproto libxi"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libxtst-libXtst-${VERSION}
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr --without-xmlto
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

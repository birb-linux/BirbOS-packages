NAME="libxdmcp"
DESC="Library implementing the X Display Manager Control Protocol"
VERSION="1.1.4"
SOURCE="https://www.x.org/pub/individual/lib/libXdmcp-${VERSION}.tar.xz"
CHECKSUM="0b4056a282c1e14323d5daef8fb5345d"
DEPS="xorgproto"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXdmcp-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$FAKEROOT/$NAME/usr/share/doc/libXdmcp-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make -j${MAKEOPTS} check
}

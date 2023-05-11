NAME="libxcb"
DESC="Interface to the X Window System protocol"
VERSION="1.15"
SOURCE="https://xorg.freedesktop.org/archive/individual/lib/libxcb-${VERSION}.tar.xz"
CHECKSUM="39c0fc337e738ad6c908e7cce90957d0"
DEPS="libxau xcb-proto libxdmcp"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	PYTHON=python3                \
	./configure $XORG_CONFIG      \
				--without-doxygen \
				--docdir='${datadir}'/doc/libxcb-${VERSION}

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

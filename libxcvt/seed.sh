NAME="libxcvt"
DESC="A library providing a standalone version of the X server implementation of the VESA CVT standard timing modelines generator"
VERSION="0.1.2"
SOURCE="https://www.x.org/pub/individual/lib/libxcvt-${VERSION}.tar.xz"
CHECKSUM="b553fdb6024c5a137ff925bf4c337724"
DEPS="meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=$XORG_PREFIX --buildtype=release ..
	ninja
}

_install()
{
	ninja install
}

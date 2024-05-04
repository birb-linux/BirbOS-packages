NAME="cairo"
DESC="2D graphics library with support for multiple output devices"
VERSION="1.18.0"
SOURCE="https://www.cairographics.org/releases/cairo-${VERSION}.tar.xz"
CHECKSUM="3f0685fbadc530606f965b9645bb51d9"
DEPS="xorg-libs libpng pixman fontconfig glib"
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

	meson setup --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR="$FAKEROOT/$NAME" ninja install
}

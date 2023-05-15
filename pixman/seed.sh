NAME="pixman"
DESC="A library that provides low-level pixel manipulation features such as image compositing and trapezoid rasterization"
VERSION="0.42.2"
SOURCE="https://www.cairographics.org/releases/pixman-${VERSION}.tar.gz"
CHECKSUM="a0f6ab8a1d8e0e2cd80e935525e2a864"
DEPS=""
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

	meson --prefix=$FAKEROOT/$NAME/usr --buildtype=release
	ninja
}

_install()
{
	ninja install
}

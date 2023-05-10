NAME="fribidi"
DESC="Implementation of the Unicode Bidirectional Algorithm (BIDI)"
VERSION="1.0.12"
SOURCE="https://github.com/fribidi/fribidi/releases/download/v${VERSION}/fribidi-${VERSION}.tar.xz"
CHECKSUM="21185b398635a7fc0d3ff0a7578c4791"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=$FAKEROOT/$NAME/usr --buildtype=release ..
	ninja
}

_install()
{
	ninja install
}

_test()
{
	ninja test
}

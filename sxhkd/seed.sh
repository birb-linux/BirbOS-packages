NAME="sxhkd"
DESC="Simple X hotkey daemon"
VERSION="0.6.2"
SOURCE="https://github.com/baskerville/sxhkd/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="c16018c6904b5c9ec7d6ef9e9953178e"
DEPS="libxcb xcb-util-keysyms"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${MAKEOPTS}
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr install
}

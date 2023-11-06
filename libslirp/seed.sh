NAME="libslirp"
DESC="User-mode networking library used by virtual machines, containers or various tools"
VERSION="4.7.0"
SOURCE="https://gitlab.freedesktop.org/slirp/libslirp/-/archive/v${VERSION}/libslirp-v${VERSION}.tar.bz2"
CHECKSUM="b815c4de99265559caf5ef635a213609"
DEPS="glib meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-v${VERSION}
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
	DESTDIR=$FAKEROOT/$NAME ninja install
}

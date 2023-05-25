NAME="libgudev"
DESC="GObject bindings for libudev"
VERSION="237"
SOURCE="https://download.gnome.org/sources/libgudev/${VERSION}/libgudev-${VERSION}.tar.xz"
CHECKSUM="a7783083cd74957d3a727ddc4737ee84"
DEPS="glib"
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

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

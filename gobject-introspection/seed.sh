NAME="gobject-introspection"
DESC="The GObject Introspection is used to describe the program APIs and collect them in a uniform, machine readable format"
VERSION="1.74.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/gobject-introspection/${SHORT_VERSION}/gobject-introspection-${VERSION}.tar.xz"
CHECKSUM="ed4e290c5ca8737a62c9a7f5347ae10d"
DEPS="glib meson ninja"
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

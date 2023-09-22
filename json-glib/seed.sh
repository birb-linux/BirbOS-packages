NAME="json-glib"
DESC="JSON GLib package is a library providing serialization and deserialization support for the JavaScript Object Notation (JSON)"
VERSION="1.6.6"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/json-glib/${SHORT_VERSION}/json-glib-${VERSION}.tar.xz"
CHECKSUM="9c40fcd8cdbf484dd1704480afefae14"
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

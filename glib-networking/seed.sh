NAME="glib-networking"
DESC="Network related gio modules for GLib"
VERSION="2.74.0"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{ print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/glib-networking/${SHORT_VERSION}/glib-networking-${VERSION}.tar.xz"
CHECKSUM="7fc6ca153af0833fdf5c65044a3f7c42"
DEPS="glib gnutls make-ca"
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

	meson --prefix=/usr       \
		  --openssl=enabled   \
		  --buildtype=release
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_test()
{
	ninja test
}

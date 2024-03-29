NAME="glib-networking"
DESC="Network related gio modules for GLib"
VERSION="2.76.1"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/glib-networking/${SHORT_VERSION}/glib-networking-${VERSION}.tar.xz"
CHECKSUM="05b519bb1f009789e6b82af88ed1b59a"
DEPS="glib gnutls make-ca meson ninja"
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

	meson setup --prefix=/usr       \
		  		--buildtype=release \
				-Dlibproxy=disabled \
				..
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

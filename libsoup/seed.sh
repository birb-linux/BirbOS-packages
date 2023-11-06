NAME="libsoup"
DESC="HTTP client/server library for GNOME"
VERSION="3.4.2"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/libsoup/${SHORT_VERSION}/libsoup-${VERSION}.tar.xz"
CHECKSUM="cd8b0fc5d53331b9c0b5b22aabac4294"
DEPS="glib-networking libpsl libxml2 nghttp2 sqlite mit-kerberos5 meson ninja"
FLAGS="wip"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix API docs installation path
	sed 's/apiversion/soup_version/' -i docs/reference/meson.build

	mkdir build
	cd    build

	meson --prefix=/usr          \
		  --buildtype=release    \
		  -Dvapi=disabled        \
		  -Dgssapi=enabled       \
		  -Dsysprof=disabled     \
		  --wrap-mode=nofallback \
		  ..

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

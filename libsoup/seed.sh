NAME="libsoup"
DESC="HTTP client/server library for GNOME"
VERSION="3.2.2"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{ print $1 "." $2 }')"
SOURCE="https://download.gnome.org/sources/libsoup/${SHORT_VERSION}/libsoup-${VERSION}.tar.xz"
CHECKSUM="33902089d52f862d6b39680dd4c4e3aa"
DEPS="glib-networking libpsl libxml2 nghttp2 sqlite mit-kerberos5"
FLAGS=""

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

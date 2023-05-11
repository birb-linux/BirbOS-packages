NAME="glib"
DESC="Low-level libraries useful for providing data structure handling for C, portability wrappers and interfaces for such runtime functionality as an event loop, threads, dynamic loading and an object system"
VERSION="2.74.5"
SHORT_VERSION="$(echo "${VERSION}" | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/glib/${SHORT_VERSION}/glib-${VERSION}.tar.xz"
CHECKSUM="7561501d9f63f3418ddb23d2903cc968"
DEPS="libxslt pcre2"
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

	# libxslt will cause some errors, but they are harmless
	set +e

	meson --prefix=$FAKEROOT/$NAME/usr \
		  --buildtype=release \
		  -Dman=true          \
		  ..

	ninja

	set -e
}

_install()
{
	set +e
	ninja install
	set -e

	mkdir -p $FAKEROOT/$NAME/usr/share/doc/glib-${VERSION}
	cp -r ../docs/reference/{gio,glib,gobject} $FAKEROOT/$NAME/usr/share/doc/glib-${VERSION}
}

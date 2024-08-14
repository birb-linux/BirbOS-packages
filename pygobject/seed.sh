# shellcheck disable=SC2034
NAME="pygobject"
DESC="Python bindings for the GObject class from GLib"
VERSION="3.46.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/pygobject/${SHORT_VERSION}/pygobject-${VERSION}.tar.xz"
CHECKSUM="56c36bfe6f24fa28182a7adcd3815b2c"
DEPS="gobject-introspection pycairo meson ninja"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename "$SOURCE")"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	mkdir build
	cd    build || exit 1

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

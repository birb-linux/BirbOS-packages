NAME="pygobject"
DESC="Python bindings for the GObject class from GLib"
VERSION="3.42.2"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/pygobject/${SHORT_VERSION}/pygobject-${VERSION}.tar.xz"
CHECKSUM="c5b31bb58156661c0954f1dbfc950fc9"
DEPS="gobject-introspection pycairo"
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

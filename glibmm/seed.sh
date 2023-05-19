NAME="glibmm"
DESC="Set of C++ bindings for GLib"
VERSION="2.66.5"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/glibmm/${SHORT_VERSION}/glibmm-${VERSION}.tar.xz"
CHECKSUM="b6c2c8ba36abf6c5e43cee459a74b8a1"
DEPS="glib libsigc++"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir bld &&
	cd    bld &&

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

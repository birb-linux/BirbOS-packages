NAME="gtkmm"
DESC="C++ interface to GTK+ 3"
VERSION="3.24.7"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/gtkmm/${SHORT_VERSION}/gtkmm-${VERSION}.tar.xz"
CHECKSUM="9576353c26db5e273a074264b68ad6cf"
DEPS="atkmm gtk+ pangomm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir gtkmm3-build
	cd    gtkmm3-build

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

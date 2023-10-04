NAME="goffice"
DESC="A library of GLib/GTK document centric objects and utilities"
VERSION="0.10.55"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/goffice/${SHORT_VERSION}/goffice-${VERSION}.tar.xz"
CHECKSUM="c3e5f9e2fcdd63e4cd50721610abefc2"
DEPS="gtk+ libgsf librsvg libxslt which"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make check
}

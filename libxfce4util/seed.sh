NAME="libxfce4util"
DESC="Basic utility library for the Xfce desktop environment"
VERSION="4.18.1"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://archive.xfce.org/src/xfce/libxfce4util/${SHORT_VERSION}/libxfce4util-${VERSION}.tar.bz2"
CHECKSUM="4a834c5dc207f33cde0e213bc4e8b5b1"
DEPS="glib gobject-introspection vala"
FLAGS=""

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

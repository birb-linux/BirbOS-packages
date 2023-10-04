NAME="libgsf"
DESC="Library used for providing an extensible input/output abstraction layer for structured file formats"
VERSION="1.14.50"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/libgsf/${SHORT_VERSION}/libgsf-${VERSION}.tar.xz"
CHECKSUM="1e9088c9c8869532945a10f12f1829c2"
DEPS="glib libxml2 gdk-pixbuf"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static
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

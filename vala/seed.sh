NAME="vala"
DESC="Programming language for GNOME developers"
VERSION="0.56.4"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/vala/${SHORT_VERSION}/vala-${VERSION}.tar.xz"
CHECKSUM="dbb3d5b4616211e68093676099d44d56"
DEPS="glib graphviz"
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

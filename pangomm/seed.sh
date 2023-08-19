NAME="pangomm"
DESC="C++ interface to Pango"
VERSION="2.46.3"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/pangomm/${SHORT_VERSION}/pangomm-${VERSION}.tar.xz"
CHECKSUM="7af783bb04de766fafaaad26c9ed475a"
DEPS="libcairomm glibmm pango"
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

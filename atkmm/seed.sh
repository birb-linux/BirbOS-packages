NAME="atkmm"
DESC="The official C++ interface for the ATK accessibility toolkit library"
VERSION="2.28.3"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/atkmm/${SHORT_VERSION}/atkmm-${VERSION}.tar.xz"
CHECKSUM="bad12606feaaba28c4d31b8857b7099e"
DEPS="at-spi2-core glibmm meson ninja"
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

	meson --prefix=$FAKEROOT/$NAME/usr --buildtype=release ..
	ninja
}

_install()
{
	ninja install
}

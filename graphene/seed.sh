NAME="graphene"
DESC="A thin layer of types for graphics libraries"
VERSION="1.10.8"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/graphene/${SHORT_VERSION}/graphene-${VERSION}.tar.xz"
CHECKSUM="169e3c507b5a5c26e9af492412070b81"
DEPS="glib gobject-introspection"
FLAGS="test"

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

_test()
{
	ninja test
}

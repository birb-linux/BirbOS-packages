NAME="libepoxy"
DESC="Library for handling OpenGL function pointer management"
VERSION="1.5.10"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/libepoxy/${SHORT_VERSION}/libepoxy-${VERSION}.tar.xz"
CHECKSUM="10c635557904aed5239a4885a7c4efb7"
DEPS="mesa meson ninja"
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

	meson --prefix=$FAKEROOT/$NAME/usr --buildtype=release ..
	ninja
}

_install()
{
	ninja install
}

_test()
{
	ninja test
}

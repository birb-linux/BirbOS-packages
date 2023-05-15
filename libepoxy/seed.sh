NAME="libepoxy"
DESC="Library for handling OpenGL function pointer management"
VERSION="1.5.10"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/libepoxy/${SHORT_VERSION}/libepoxy-${VERSION}.tar.xz"
CHECKSUM="10c635557904aed5239a4885a7c4efb7"
DEPS="mesa"
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

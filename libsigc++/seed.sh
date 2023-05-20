NAME="libsigc++"
DESC="Typesafe callback system for standard C++"
VERSION="2.12.0"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/libsigc++/${SHORT_VERSION}/libsigc++-${VERSION}.tar.xz"
CHECKSUM="943b7aef5d74fbc4f4a3bb67bcfaae02"
DEPS="boost libxslt"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir bld
	cd    bld

	meson setup --prefix=/usr --buildtype=release ..
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

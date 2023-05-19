NAME="libcairomm"
DESC="C++ interface to Cairo"
VERSION="1.14.0"
SOURCE="https://www.cairographics.org/releases/cairomm-${VERSION}.tar.xz"
CHECKSUM="75a08d50eb08b97667e4ea2be6efa1ad"
DEPS="cairo libsigc++"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd cairomm-${VERSION}
}

_build()
{
	mkdir bld
	cd    bld

	meson --prefix=/usr       \
		  --buildtype=release \
		  -Dbuild-tests=false  \
		  -Dboost-shared=true \
		  ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

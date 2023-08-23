NAME="poco"
DESC="Powerful cross-platform C++ libraries for building network- and internet-based applications"
VERSION="1.12.4"
SOURCE="https://github.com/pocoproject/poco/archive/refs/tags/poco-${VERSION}-release.tar.gz"
CHECKSUM="0ca5d1e2f2a5e8ba2f0a83c2e6df374a"
DEPS="cmake openssl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd poco-poco-${VERSION}-release
}

_build()
{
	mkdir bld
	cd    bld

	cmake .. -DCMAKE_INSTALL_PREFIX=/usr
	cmake --build . --config Release --parallel ${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

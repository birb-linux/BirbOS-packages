NAME="abseil-cpp"
DESC="Abseil Common Libraries (C++)"
VERSION="20230802.0"
SOURCE="https://github.com/abseil/abseil-cpp/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="f40605e07aa804aa82e7090f12db7e34"
DEPS=""
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

	cmake .. -DCMAKE_INSTALL_PREFIX=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

NAME="c-ares"
DESC="C library for asynchronous DNS requests"
VERSION="1.28.1"
SOURCE="https://c-ares.haxx.se/download/c-ares-${VERSION}.tar.gz"
CHECKSUM="2b0f0df7491538a0d10f3310e13d4b5f"
DEPS="cmake"
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

	cmake  -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr ..
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

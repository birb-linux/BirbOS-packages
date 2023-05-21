NAME="c-ares"
DESC="C library for asynchronous DNS requests"
VERSION="1.19.0"
SOURCE="https://c-ares.haxx.se/download/c-ares-${VERSION}.tar.gz"
CHECKSUM="2668790bc92603e292d0fbcb25ded39c"
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

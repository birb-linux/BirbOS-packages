NAME="cava"
DESC="Cross-platform Audio Visualizer"
VERSION="0.9.0"
SOURCE="https://github.com/karlstav/cava/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="c564296de3470017820e1657855964f8"
DEPS="fftw libtool automake autoconf-archive iniparser"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

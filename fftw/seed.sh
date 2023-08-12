NAME="fftw"
DESC="C subroutine library for computing the discrete Fourier transform (DFT)"
VERSION="3.3.10"
SOURCE="http://www.fftw.org/fftw-${VERSION}.tar.gz"
CHECKSUM="8ccbf6a5ea78a16dbc3e1306e234cc5c"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	unset CFLAGS
	unset CXXFLAGS
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

NAME="openblas"
DESC="Optimized BLAS library based on GotoBLAS2 1.13 BSD version"
VERSION="0.3.23"
SOURCE="https://github.com/xianyi/OpenBLAS/releases/download/v${VERSION}/OpenBLAS-${VERSION}.tar.gz"
CHECKSUM="6c35babfc01534eb04acba653d378839"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

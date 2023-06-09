NAME="oniguruma"
DESC="Regular expression library"
VERSION="6.9.8"
SOURCE="https://github.com/kkos/oniguruma/releases/download/v${VERSION}/onig-${VERSION}.tar.gz"
CHECKSUM="ceb0ce338e6ad444615c1daac1e260a7"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd onig-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

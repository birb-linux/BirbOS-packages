NAME="lsof"
DESC="LiSt Open Files"
VERSION="4.98.0"
SOURCE="https://github.com/lsof-org/lsof/releases/download/${VERSION}/lsof-${VERSION}.tar.gz"
CHECKSUM="34404c76c56cb761adcb93fa139c9be5"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
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

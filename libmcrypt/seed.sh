NAME="libmcrypt"
DESC="Provides an uniform interface to access several encryption algorithms"
VERSION="2.5.8"
SOURCE="https://sourceforge.net/projects/mcrypt/files/Libmcrypt/${VERSION}/libmcrypt-${VERSION}.tar.gz"
CHECKSUM="0821830d930a86a5c69110837c55b7da"
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

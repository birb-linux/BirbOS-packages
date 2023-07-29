NAME="mcrypt"
DESC="Replacement for the old unix crypt program"
VERSION="2.6.8"
SOURCE="https://sourceforge.net/projects/mcrypt/files/MCrypt/${VERSION}/mcrypt-${VERSION}.tar.gz"
CHECKSUM="97639f8821b10f80943fa17da302607e"
DEPS="mhash libmcrypt zlib"
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

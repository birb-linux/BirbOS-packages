NAME="wget"
DESC="Utility useful for non-interactive downloading of files from the interwebs"
VERSION="1.21.4"
SOURCE="https://ftp.gnu.org/gnu/wget/wget-${VERSION}.tar.gz"
CHECKSUM="e7f7ca2f215b711f76584756ebd3c853"
DEPS="make-ca"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --sysconfdir=/etc  \
            --with-ssl=openssl

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}

_test()
{
	make -j${BUILD_JOBS} check
}

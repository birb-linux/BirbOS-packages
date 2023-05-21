NAME="wget"
DESC="Utility useful for non-interactive downloading of files from the interwebs"
VERSION="1.21.3"
SOURCE="https://ftp.gnu.org/gnu/wget/wget-${VERSION}.tar.gz"
CHECKSUM="e89496b15f8bf039d723926fae4d91f5"
DEPS="make-ca"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --sysconfdir=/etc  \
            --with-ssl=openssl

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}

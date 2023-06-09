NAME="libgpg-error"
DESC="Library that defines common error values for all GnuPG components"
VERSION="1.46"
SOURCE="https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${VERSION}.tar.bz2"
CHECKSUM="db41efe5aba3baad6cf266fea720095d"
DEPS=""
FLAGS="test"

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
	install -v -m644 -D README $FAKEROOT/$NAME/usr/share/doc/libgpg-error-${VERSION}/README
}

_test()
{
	make -j${BUILD_JOBS} check
}

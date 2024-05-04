NAME="inetutils"
DESC="Programs for basic networking"
VERSION="2.5"
SOURCE="https://ftp.gnu.org/gnu/inetutils/inetutils-${VERSION}.tar.xz"
CHECKSUM="9e5a6dfd2d794dc056a770e8ad4a9263"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --bindir=$FAKEROOT/$NAME/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Move a program to the proper location
	mv -v $FAKEROOT/$NAME/usr/{,s}bin/ifconfig
}

_test()
{
	make -j${BUILD_JOBS} check
}

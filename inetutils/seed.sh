NAME="inetutils"
DESC="Programs for basic networking"
VERSION="2.4"
SOURCE="https://ftp.gnu.org/gnu/inetutils/inetutils-${VERSION}.tar.xz"
CHECKSUM="319d65bb5a6f1847c4810651f3b4ba74"
DEPS=""
FLAGS="test"

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

	make -j${MAKEOPTS}
}

_install()
{
	make install

	# Move a program to the proper location
	mv -v $FAKEROOT/$NAME/usr/{,s}bin/ifconfig
}

_test()
{
	make -j${MAKEOPTS} check
}

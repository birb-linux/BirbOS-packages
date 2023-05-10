NAME="findutils"
DESC="Utilities for finding files and directories"
VERSION="4.9.0"
SOURCE="https://ftp.gnu.org/gnu/findutils/findutils-${VERSION}.tar.xz"
CHECKSUM="4a4a547e888a944b2f3af31d789a1137"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --localstatedir=/var/lib/locate

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	chown -Rv tester .
	su tester -c "PATH=$PATH make check"
}

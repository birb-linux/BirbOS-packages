NAME="m4"
DESC="Macro processor"
VERSION="1.4.19"
SOURCE="https://ftp.gnu.org/gnu/m4/m4-${VERSION}.tar.xz"
CHECKSUM="0d90823e1426f1da2fd872df0311298d"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${MAKEOPTS}
}

_test()
{
	make -j${MAKEOPTS} check
}

_install()
{
	make install
}

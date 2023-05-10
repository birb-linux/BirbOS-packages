NAME="patch"
DESC="Program for modifying or creating files by applying a 'patch' file typically created by the diff program"
VERSION="2.7.6"
SOURCE="https://ftp.gnu.org/gnu/patch/patch-${VERSION}.tar.xz"
CHECKSUM="78ad9937e4caadcba1526ef1853730d5"
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

_install()
{
	make install
}

_test()
{
	make -j${MAKEOPTS} check
}

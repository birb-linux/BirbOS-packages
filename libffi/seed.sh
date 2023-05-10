NAME="libffi"
DESC="Portable, high level programming interface to various calling conventions"
VERSION="3.4.4"
SOURCE="https://github.com/libffi/libffi/releases/download/v${VERSION}/libffi-${VERSION}.tar.gz"
CHECKSUM="0da1a5ed7786ac12dcbaf0d499d8a049"
DEPS=""
FLAGS="test 32bit test32"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static       \
            --with-gcc-arch=native

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

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	CC="gcc -m32" CXX="g++ -m32" ./configure \
		--host=i686-pc-linux-gnu \
		--prefix=$FAKEROOT/$NAME/usr \
		--libdir=/usr/lib32      \
		--disable-static         \
		--with-gcc-arch=i686

	make -j${MAKEOPTS}
}

# This function gets called if the 'test32' flag has been specified
_test32()
{
	make -j${MAKEOPTS} check
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}

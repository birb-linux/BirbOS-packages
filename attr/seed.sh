NAME="attr"
DESC="Utilities to administer the extended attributes of filesystem objects"
VERSION="2.5.1"
SOURCE="https://download.savannah.gnu.org/releases/attr/attr-${VERSION}.tar.gz"
CHECKSUM="ac1c5a7a084f0f83b8cace34211f64d8"
DEPS=""
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

# If the package has any tests, run them here
# To enable this function, specify the 'test' flag
#
# Also, birb needs to be run with special arguments to run tests
# when installing packages
_test()
{
	make -j${BUILD_JOBS} check
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	CC="gcc -m32" ./configure \
		--prefix=$FAKEROOT/$NAME/usr \
		--disable-static      \
		--sysconfdir=/etc     \
		--libdir=/usr/lib32   \
		--host=i686-pc-linux-gnu

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}

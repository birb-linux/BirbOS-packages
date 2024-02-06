NAME="libarchive"
DESC="Interface for reading/writing various compression formats"
VERSION="3.7.1"
SOURCE="https://github.com/libarchive/libarchive/releases/download/v${VERSION}/libarchive-${VERSION}.tar.xz"
CHECKSUM="11a217b523dcdd178490bdb1f83353f3"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Remove an invalid pkgconfig entry
	sed -i "s/iconv //" $FAKEROOT/$NAME/usr/lib/pkgconfig/libarchive.pc
}

_test()
{
	LC_ALL=C make -j${BUILD_JOBS} check
}

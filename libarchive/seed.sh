NAME="libarchive"
DESC="Interface for reading/writing various compression formats"
VERSION="3.6.2"
SOURCE="https://github.com/libarchive/libarchive/releases/download/v${VERSION}/libarchive-${VERSION}.tar.xz"
CHECKSUM="72cbb3c085624c825f627bfc8f52ce53"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j$(nproc)
}

_install()
{
	make install

	# Remove an invalid pkgconfig entry
	sed -i "s/iconv //" $FAKEROOT/$NAME/usr/lib/pkgconfig/libarchive.pc
}

_test()
{
	LC_ALL=C make -j$(nproc) check
}

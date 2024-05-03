NAME="zlib"
DESC="Compression and decompression routines used by some programs"
VERSION="1.3.1"
SOURCE="https://zlib.net/zlib-${VERSION}.tar.xz"
CHECKSUM="9855b6d802d7fe5b7bd5b196a2271655"
DEPS=""
FLAGS="32bit important"

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

	# Remove a useless static library
	rm -fv $FAKEROOT/$NAME/usr/lib/libz.a
}

_build32()
{
	make distclean
	CFLAGS+=" -m32" CXXFLAGS+=" -m32" \
	./configure --prefix=$FAKEROOT/$NAME/usr \
			--libdir=/usr/lib32

	make -j${BUILD_JOBS}
}

_install32()
{
	mkdir -pv $FAKEROOT/$NAME/usr/lib32

	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}

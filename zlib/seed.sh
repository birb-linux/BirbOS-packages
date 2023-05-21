NAME="zlib"
DESC="Compression and decompression routines used by some programs"
VERSION="1.2.13"
SOURCE="https://zlib.net/zlib-${VERSION}.tar.xz"
CHECKSUM="7d9fc1d78ae2fa3e84fe98b77d006c63"
DEPS=""
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install

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

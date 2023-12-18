NAME="gmp"
DESC="Math libraries and useful functions for arbitrary precision arithmetic"
VERSION="6.3.0"
SOURCE="https://ftp.gnu.org/gnu/gmp/gmp-${VERSION}.tar.xz"
CHECKSUM="956dc04e864001a9c22429f761f2c283"
DEPS="m4 xz"
FLAGS="32bit test test32 important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr   \
            --enable-cxx     	\
            --disable-static 	\
            --docdir=/usr/share/doc/gmp-${VERSION}

	make -j${BUILD_JOBS}
	make html
}

_test()
{
	make -j${BUILD_JOBS} check
}

_install()
{
	make install
	make install-html
}

_build32()
{
	make distclean

	ABI="32" \
	CFLAGS="-m32 -O2 -pedantic -fomit-frame-pointer -mtune=generic -march=i686" \
	CXXFLAGS="$CFLAGS" \
	PKG_CONFIG_PATH="/usr/lib32/pkgconfig" \
	./configure                      \
		--host=i686-pc-linux-gnu     \
		--prefix=$FAKEROOT/$NAME/usr \
		--disable-static             \
		--enable-cxx                 \
		--libdir=/usr/lib32          \
		--includedir=/usr/include/m32/gmp

	sed -i 's/$(exec_prefix)\/include/$\(includedir\)/' Makefile
	make -j${BUILD_JOBS}
}

_test32()
{
	make -j${BUILD_JOBS} check
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	cp -Rv DESTDIR/usr/include/m32/* $FAKEROOT/$NAME/usr/include/m32/
	rm -rf DESTDIR
}

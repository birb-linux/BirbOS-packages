NAME="gmp"
DESC="Math libraries and useful functions for arbitrary precision arithmetic"
VERSION="6.2.1"
SOURCE="https://ftp.gnu.org/gnu/gmp/gmp-${VERSION}.tar.xz"
CHECKSUM="0b82665c4a92fd2ade7440c13fcaa42b"
DEPS="m4 xz"
FLAGS="32bit"

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

	make -j$(nproc)
	make html

	# Run the tests
	make -j$(nproc) check
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
	make -j$(nproc)

	# Run the tests
	make -j$(nproc) check
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	cp -Rv DESTDIR/usr/include/m32/* $FAKEROOT/$NAME/usr/include/m32/
	rm -rf DESTDIR
}

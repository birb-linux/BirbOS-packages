NAME="zlib"
DESC="Compression and decompression routines used by some programs"
VERSION="1.2.13"
SOURCE="https://zlib.net/zlib-${VERSION}.tar.xz"
CHECKSUM="7d9fc1d78ae2fa3e84fe98b77d006c63"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	SRC_DIR="$(pwd)"

	# Build the 64bit binaries
	mkdir -p build_64 ; cd build_64
	../configure --prefix=$FAKEROOT/$NAME/usr

	make -j$(nproc)

	cd $SRC_DIR


	# Build the 32bit binaries
	mkdir -p build_32 ; cd build_32
	CFLAGS+=" -m32" CXXFLAGS+=" -m32" \
	../configure --prefix=$FAKEROOT/$NAME/usr \
			--libdir=/usr/lib32

	make -j$(nproc)

	cd $SRC_DIR


	# Build the x32bit binaries
	mkdir -p build_x32 ; cd build_x32
	CFLAGS+=" -mx32" CXXFLAGS+=" -mx32" \
	../configure --prefix=$FAKEROOT/$NAME/usr \
		--libdir=/usr/libx32

	make -j$(nproc)

	cd $SRC_DIR
}

_install()
{
	cd $SRC_DIR/build_64
	make install

	mkdir -pv $FAKEROOT/$NAME/usr/{lib32,libx32}

	cd $SRC_DIR/build_32
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR

	cd $SRC_DIR/build_x32
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/libx32/* $FAKEROOT/$NAME/usr/libx32
	rm -rf DESTDIR

	# Remove a useless static library
	rm -fv $FAKEROOT/$NAME/usr/lib/libz.a
}

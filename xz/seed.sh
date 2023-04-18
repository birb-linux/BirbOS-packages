NAME="xz"
DESC="Compression and decompression utilities"
VERSION="5.4.2"
SOURCE="https://tukaani.org/xz/xz-${VERSION}.tar.xz"
CHECKSUM="1dcdf002d9a69f48ff67be84964af0d8"
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
	mkdir -p build_64 build_32 build_x32

	cd $SRC_DIR/build_64
	../configure --prefix=$FAKEROOT/$NAME/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.4.2

	make -j$(nproc)

	cd $SRC_DIR/build_32
	CC="gcc -m32" ../configure 	      \
		--host=i686-pc-linux-gnu      \
		--prefix=$FAKEROOT/$NAME/usr  \
		--libdir=/usr/lib32           \
		--disable-static

	make -j$(nproc)

	cd $SRC_DIR/build_x32
	CC="gcc -mx32" ../configure \
		--host=x86_64-pc-linux-gnux32 \
		--prefix=$FAKEROOT/$NAME/usr  \
		--libdir=/usr/libx32          \
		--disable-static

	make -j$(nproc)
}

_install()
{
	cd $SRC_DIR/build_64
	make install

	cd $SRC_DIR/build_32
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR

	cd $SRC_DIR/build_x32
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/libx32/* $FAKEROOT/$NAME/usr/libx32
	rm -rf DESTDIR
}

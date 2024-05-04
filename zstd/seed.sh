NAME="zstd"
DESC="Real-time compression algorithm"
VERSION="1.5.6"
SOURCE="https://github.com/facebook/zstd/releases/download/v${VERSION}/zstd-${VERSION}.tar.gz"
CHECKSUM="5a473726b3445d0e5d6296afd1ab6854"
DEPS=""
FLAGS="32bit important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS} prefix=/usr
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME prefix=/usr install

	# Remove the static library
	rm -vf $FAKEROOT/$NAME/usr/lib/libzstd.a
}

_build32()
{
	make clean

	CC="gcc -m32" make -j${BUILD_JOBS} prefix=$FAKEROOT/$NAME/usr
}

_install32()
{
	make prefix=/usr DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib/* $FAKEROOT/$NAME/usr/lib32/
	sed -e "/^libdir/s/lib$/lib32/" -i $FAKEROOT/$NAME/usr/lib32/pkgconfig/libzstd.pc
	rm -rf DESTDIR
}

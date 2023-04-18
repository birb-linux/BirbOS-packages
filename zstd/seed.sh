NAME="zstd"
DESC="Real-time compression algorithm"
VERSION="1.5.5"
SOURCE="https://github.com/facebook/zstd/releases/download/v${VERSION}/zstd-${VERSION}.tar.gz"
CHECKSUM="63251602329a106220e0a5ad26ba656f"
DEPS=""
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j$(nproc) prefix=$FAKEROOT/$NAME/usr
}

_install()
{
	make prefix=$FAKEROOT/$NAME/usr install

	# Remove the static library
	rm -v $FAKEROOT/$NAME/usr/lib/libzstd.a
}

_build32()
{
	make clean

	CC="gcc -m32" make -j$(nproc) prefix=$FAKEROOT/$NAME/usr
}

_install32()
{
	make prefix=$FAKEROOT/$NAME/usr DESTDIR=$FAKEROOT/$NAME install
	cp -Rv $FAKEROOT/$NAME/usr/lib/* $FAKEROOT/$NAME/usr/lib32/
	sed -e "/^libdir/s/lib$/lib32/" -i $FAKEROOT/$NAME/usr/lib32/pkgconfig/libzstd.pc
	rm -rf $FAKEROOT/$NAME/var
}

_buildx32()
{
	make clean

	CC="gcc -mx32" make -j$(nproc) prefix=$FAKEROOT/$NAME/usr
}

_installx32()
{
	make prefix=$FAKEROOT/$NAME/usr DESTDIR=$FAKEROOT/$NAME install
	cp -Rv $FAKEROOT/$NAME/usr/lib/* $FAKEROOT/$NAME/usr/libx32/
	sed -e "/^libdir/s/lib$/libx32/" -i $FAKEROOT/$NAME/usr/libx32/pkgconfig/libzstd.pc
	rm -rf $FAKEROOT/$NAME/var
}

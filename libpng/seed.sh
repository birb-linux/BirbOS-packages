NAME="libpng"
DESC="Contains libraries used by other programs for reading and writing PNG files"
VERSION="1.6.39"
SOURCE="https://downloads.sourceforge.net/libpng/libpng-${VERSION}.tar.xz"
CHECKSUM="aa1ae92e172417039bda072b702f6326"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Apply a patch that adds support for animated png files
	gzip -cd $PKG_PATH/libpng-1.6.39-apng.patch.gz | patch -p1

	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make install
	mkdir -v $FAKEROOT/$NAME/usr/share/doc/libpng-${VERSION}
	cp -v README libpng-manual.txt $FAKEROOT/$NAME/usr/share/doc/libpng-${VERSION}
}

_test()
{
	make -j${BUILD_JOBS} check
}

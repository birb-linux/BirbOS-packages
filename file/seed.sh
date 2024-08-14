NAME="file"
DESC="Utility for determining the type of a given file or files"
VERSION="5.45"
SOURCE="https://astron.com/pub/file/file-${VERSION}.tar.gz"
CHECKSUM="26b2a96d4e3a8938827a1e572afd527a"
DEPS=""
FLAGS="32bit important"

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
}

_build32()
{
	make distclean

	CC="gcc -m32" ./configure \
		--prefix=$FAKEROOT/$NAME/usr \
		--libdir=/usr/lib32   \
		--host=i686-pc-linux-gnu

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}

NAME="libmng"
DESC="Libraries for reading and writing Multiple-image Network Graphics (MNG) files"
VERSION="2.0.3"
SOURCE="https://downloads.sourceforge.net/libmng/libmng-${VERSION}.tar.xz"
CHECKSUM="e9e899adb1b681b17f14d91e261878c5"
DEPS="libjpeg-turbo little-cms"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	install -v -m755 -d        $FAKEROOT/$NAME/usr/share/doc/libmng-${VERSION}
	install -v -m644 doc/*.txt $FAKEROOT/$NAME/usr/share/doc/libmng-${VERSION}
}

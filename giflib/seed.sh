NAME="giflib"
DESC="Libraries for reading and writing GIFs as well as programs for converting and working with GIF files"
VERSION="5.2.1"
SOURCE="https://sourceforge.net/projects/giflib/files/giflib-${VERSION}.tar.gz"
CHECKSUM="6f03aee4ebe54ac2cc1ab3e4b0a049e5"
DEPS="xmlto"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr install

	rm -fv $FAKEROOT/$NAME/usr/lib/libgif.a

	find doc \( -name Makefile\* -o -name \*.1 \
			 -o -name \*.xml \) -exec rm -v {} \;

	install -v -dm755 $FAKEROOT/$NAME/usr/share/doc/giflib-${VERSION}
	cp -v -R doc/* $FAKEROOT/$NAME/usr/share/doc/giflib-${VERSION}
}

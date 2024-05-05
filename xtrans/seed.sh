NAME="xtrans"
DESC="X Transport Interface"
VERSION="1.4.0"
SOURCE="https://www.x.org/archive//individual/lib/xtrans-${VERSION}.tar.bz2"
CHECKSUM="ce2fb8100c6647ee81451ebe388b17ad"
DEPS="fontconfig libxcb elogind"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Make xtrans available for 32bit packages
	mkdir -p "$FAKEROOT/$NAME/usr/lib32/pkgconfig"
	cp -v "$FAKEROOT/$NAME/usr/share/pkgconfig/xtrans.pc" "$FAKEROOT/$NAME/usr/lib32/pkgconfig/"
}

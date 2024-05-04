NAME="links"
DESC="Text and graphics mode WWW browser"
VERSION="2.29"
SOURCE="http://links.twibright.com/download/links-${VERSION}.tar.bz2"
CHECKSUM="f60b87ffee090c5d6820951eba710572"
DEPS="libevent"
FLAGS=""

# TODO: Add support for graphics mode via GPM

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --mandir=$FAKEROOT/$NAME/usr/share/man
	make -j${BUILD_JOBS}
}

_install()
{
	make install
	install -v -d -m755 $FAKEROOT/$NAME/usr/share/doc/links-${VERSION}
	install -v -m644 doc/links_cal/* KEYS BRAILLE_HOWTO \
		$FAKEROOT/$NAME/usr/share/doc/links-${VERSION}
}

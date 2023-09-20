NAME="dhex"
DESC="ncurses-based hex-editor with diff mode"
VERSION="0.69"
SOURCE="https://www.dettus.net/dhex/dhex_${VERSION}.tar.gz"
CHECKSUM="64d557437fe110c19f23ed3e9bbcdd54"
DEPS="ncurses"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}_${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	DESTDIR="$FAKEROOT/$NAME/usr"
	MANDIR="$FAKEROOT/$NAME/usr/share"

	strip dhex
	cp dhex 			"$DESTDIR/bin"
	cp dhex.1 			"$MANDIR/man/man1"
	cp dhexrc.5 		"$MANDIR/man/man5"
	cp dhex_markers.5 	"$MANDIR/man/man5"
	cp dhex_searchlog.5 "$MANDIR/man/man5"


	unset DESTDIR MANDIR
}

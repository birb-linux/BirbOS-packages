NAME="gettext"
DESC="Utilities for internationalization and localization"
VERSION="0.21.1"
SOURCE="https://ftp.gnu.org/gnu/gettext/gettext-${VERSION}.tar.xz"
CHECKSUM="27fcc8a42dbc8f334f23a08f1f2fe00a"
DEPS="acl ncurses"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --disable-static \
            --docdir=/usr/share/doc/gettext-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
	chmod -v 0755 $FAKEROOT/$NAME/usr/lib/preloadable_libintl.so
}

_test()
{
	make -j${BUILD_JOBS} check
}

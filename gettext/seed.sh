NAME="gettext"
DESC="Utilities for internationalization and localization"
VERSION="0.22.5"
SOURCE="https://ftp.gnu.org/gnu/gettext/gettext-${VERSION}.tar.xz"
CHECKSUM="3ae5580599d84be93e6213930facb2db"
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

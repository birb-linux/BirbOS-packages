NAME="man-db"
DESC="Programs for finding and viewing man pages"
VERSION="2.12.1"
SOURCE="https://download.savannah.gnu.org/releases/man-db/man-db-${VERSION}.tar.xz"
CHECKSUM="7b044e5020aab89db41ac7ee59d6d84a"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr                         \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/man-db-${VERSION} \
            --sysconfdir=/etc                     \
            --disable-setuid                      \
            --enable-cache-owner=bin              \
            --with-browser=/usr/bin/lynx          \
            --with-vgrind=/usr/bin/vgrind         \
            --with-grap=/usr/bin/grap             \
            --with-systemdtmpfilesdir=            \
            --with-systemdsystemunitdir=

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}

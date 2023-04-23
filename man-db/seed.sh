NAME="man-db"
DESC="Programs for finding and viewing man pages"
VERSION="2.11.2"
SOURCE="https://download.savannah.gnu.org/releases/man-db/man-db-${VERSION}.tar.xz"
CHECKSUM="a7d59fb2df6158c44f8f7009dcc6d875"
DEPS=""
FLAGS="test"

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

	make -j$(nproc)
}

_install()
{
	make install
}

_test()
{
	make -j$(nproc) check
}

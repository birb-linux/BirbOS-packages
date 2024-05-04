NAME="gparted"
DESC="Gnome Partition Editor, a Gtk 3 GUI for other command line tools that can create, reorganise or delete disk partitions"
VERSION="1.6.0"
SOURCE="https://downloads.sourceforge.net/gparted/gparted-${VERSION}.tar.gz"
CHECKSUM="b2006a0a3f35853e7d7dc34c87db11f2"
DEPS="gtkmm parted"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr    \
            --disable-doc    \
            --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}

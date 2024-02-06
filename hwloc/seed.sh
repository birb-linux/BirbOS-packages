NAME="hwloc"
DESC="Displays the hardware topology in convenient formats"
VERSION="2.10.0"
SOURCE="https://download.open-mpi.org/release/hwloc/v$(short_version ${VERSION})/hwloc-${VERSION}.tar.gz"
CHECKSUM="bf8188ab705b248bdcc5dfdae2d95065"
DEPS="pciutils libxml2 ncurses eudev libpciaccess"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

NAME="libnl"
DESC="Collection of libraries providing APIs to netlink protocol based Linux kernel interfaces"
VERSION="3.7.0"
ALT_VERSION="$(echo $VERSION | sed 's/\./_/g')"
SOURCE="https://github.com/thom311/libnl/releases/download/libnl${ALT_VERSION}/libnl-${VERSION}.tar.gz"
CHECKSUM="b381405afd14e466e35d29a112480333"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

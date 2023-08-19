NAME="libndp"
DESC="Wrapper for IPv6 Neighbor Discovery Protocol"
VERSION="1.8"
SOURCE="http://libndp.org/files/libndp-${VERSION}.tar.gz"
CHECKSUM="c7e775fd5a9d676e8cba9c3732c4df93"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr    \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

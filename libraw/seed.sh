NAME="libraw"
DESC="Library for reading RAW files obtained from digital photo cameras"
VERSION="0.21.1"
SOURCE="https://www.libraw.org/data/LibRaw-${VERSION}.tar.gz"
CHECKSUM="2942732de752f46baccd9c6d57823b7b"
DEPS="libjpeg-turbo jasper little-cms"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd LibRaw-${VERSION}
}

_build()
{
	autoreconf -fiv
	./configure --prefix=/usr      \
				--enable-jpeg      \
				--enable-jasper    \
				--enable-lcms      \
				--disable-static   \
				--disable-examples \
				--docdir=/usr/share/doc/libraw-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

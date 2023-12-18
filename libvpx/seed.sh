NAME="libvpx"
DESC="Reference implementations of the VP8 Codec"
VERSION="1.13.1"
SOURCE="https://github.com/webmproject/libvpx/archive/v${VERSION}/libvpx-${VERSION}.tar.gz"
CHECKSUM="d2c9de1c247f18a204e75ecefa7a2217"
DEPS="nasm which"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i 's/cp -p/cp/' build/make/Makefile

	mkdir libvpx-build
	cd    libvpx-build

	../configure --prefix=$FAKEROOT/$NAME/usr    \
				 --enable-shared  \
				 --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

NAME="libva"
DESC="Library which provides access to hardware accelerated video processing"
VERSION="2.17.0"
SOURCE="https://github.com/intel/libva/releases/download/${VERSION}/libva-${VERSION}.tar.bz2"
CHECKSUM="727e7c76102b926c8411b8468fd194f5"
DEPS="libdrm mesa"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${MAKEOPTS}
}

_install()
{
	make install
}

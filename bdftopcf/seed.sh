NAME="bdftopcf"
DESC="Convert X font from Bitmap Distribution Format to Portable Compiled Format"
VERSION="1.1.1"
SOURCE="https://gitlab.freedesktop.org/xorg/util/bdftopcf/-/archive/bdftopcf-${VERSION}/bdftopcf-bdftopcf-${VERSION}.tar.gz"
CHECKSUM="bb9ff1d1cb088d97c1dcb28f0d08179c"
DEPS="xorgproto util-macros"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${NAME}-${VERSION}
}

_build()
{
	./autogen.sh
	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

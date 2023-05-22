NAME="xclip"
DESC="Command line interface to the X11 clipboard"
VERSION="0.13"
SOURCE="https://github.com/astrand/xclip/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="81e49f56288f299e3389a019f2550ad2"
DEPS="libx11 libxmu libxt"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	autoreconf
	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make install
	make install.man
}

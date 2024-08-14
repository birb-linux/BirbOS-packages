NAME="libuv"
DESC="Multi-platform support library with a focus on asynchronous I/O"
VERSION="1.48.0"
SOURCE="https://dist.libuv.org/dist/v${VERSION}/libuv-v${VERSION}.tar.gz"
CHECKSUM="a808517c32ebd07c561bf21a4e30aeab"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-v${VERSION}
}

_build()
{
	sh autogen.sh
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

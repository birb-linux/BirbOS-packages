NAME="libuv"
DESC="Multi-platform support library with a focus on asynchronous I/O"
VERSION="1.44.2"
SOURCE="https://dist.libuv.org/dist/v${VERSION}/libuv-v${VERSION}.tar.gz"
CHECKSUM="0addbddcb1098e2c1c99f03f0108e1e7"
DEPS=""
FLAGS=""

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

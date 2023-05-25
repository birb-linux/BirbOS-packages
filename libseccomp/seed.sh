NAME="libseccomp"
DESC="An easy to use and platform independent interface to the Linux kernel's syscall filtering mechanism"
VERSION="2.5.4"
SOURCE="https://github.com/seccomp/libseccomp/releases/download/v${VERSION}/libseccomp-${VERSION}.tar.gz"
CHECKSUM="74008bb33234e0c2a0d998e7bee5c625"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static &&
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}

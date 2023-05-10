NAME="nspr"
DESC="Netscape Portable Runtime (NSPR) provides a platform-neutral API for system level and libc like functions"
VERSION="4.35"
SOURCE="https://archive.mozilla.org/pub/nspr/releases/v${VERSION}/src/nspr-${VERSION}.tar.gz"
CHECKSUM="5e0acf9fbdde85181bddd510f4624841"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	cd nspr
	sed -ri '/^RELEASE/s/^/#/' pr/src/misc/Makefile.in
	sed -i 's#$(LIBRARY) ##'   config/rules.mk

	./configure --prefix=$FAKEROOT/$NAME/usr \
				--with-mozilla \
				--with-pthreads \
				$([ $(uname -m) = x86_64 ] && echo --enable-64bit)

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

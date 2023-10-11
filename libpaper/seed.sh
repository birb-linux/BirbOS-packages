NAME="libpaper"
DESC="libpaper provides a simple way for applications to take actions based on a system or user-specified paper size"
VERSION="2.1.1"
SOURCE="https://github.com/rrthomas/libpaper/releases/download/v${VERSION}/libpaper-${VERSION}.tar.gz"
CHECKSUM="3ee7420ed7afae14a3387a4a0e68c60f"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --disable-static     \
            --enable-relocatable \
            --docdir=/usr/share/doc/libpaper-${VERSION}

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

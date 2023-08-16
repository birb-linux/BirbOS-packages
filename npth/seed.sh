NAME="npth"
DESC="Portable POSIX/ANSI-C based library for Unix platforms which provides non-preemptive priority-based scheduling for multithreading inside event-driven applications"
VERSION="1.6"
SOURCE="https://www.gnupg.org/ftp/gcrypt/npth/npth-${VERSION}.tar.bz2"
CHECKSUM="375d1a15ad969f32d25f1a7630929854"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
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

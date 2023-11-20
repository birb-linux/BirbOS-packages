NAME="libaio"
DESC="Asynchronous I/O facility that has a richer API and capability set than the simple POSIX async I/O facility"
VERSION="0.3.113"
SOURCE="https://pagure.io/libaio/archive/libaio-${VERSION}/libaio-${VERSION}.tar.gz"
CHECKSUM="605237f35de238dfacc83bcae406d95d"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Skip installing static libraries
	sed -i '/install.*libaio.a/s/^/#/' src/Makefile

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}

_test()
{
	make partcheck
}

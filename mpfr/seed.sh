NAME="mpfr"
DESC="Functions for multiple precision math"
VERSION="4.2.0"
SOURCE="https://ftp.gnu.org/gnu/mpfr/mpfr-${VERSION}.tar.xz"
CHECKSUM="a25091f337f25830c16d2054d74b5af7"
DEPS="gmp"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a test case based on a bug of old glibc releases
	sed -e 's/+01,234,567/+1,234,567 /' \
		-e 's/13.10Pd/13Pd/'            \
		-i tests/tsprintf.c

	./configure --prefix=$FAKEROOT/$NAME/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-${VERSION}

	make -j${BUILD_JOBS}
	make html
}

_test()
{
	make -j${BUILD_JOBS} check
}

_install()
{
	make install
	make install-html
}

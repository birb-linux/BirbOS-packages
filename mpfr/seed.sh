NAME="mpfr"
DESC="Functions for multiple precision math"
VERSION="4.2.0"
SOURCE="https://ftp.gnu.org/gnu/mpfr/mpfr-${VERSION}.tar.xz"
CHECKSUM="a25091f337f25830c16d2054d74b5af7"
DEPS=""
FLAGS=""

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
            --docdir=/usr/share/doc/mpfr-4.2.0

	make -j$(nproc)
	make html

	# Run tests
	make check
}

_install()
{
	make install
	make install-html
}

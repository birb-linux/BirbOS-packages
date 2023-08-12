NAME="dejagnu"
DESC="Framework for running test suites on GNU tools"
VERSION="1.6.3"
SOURCE="https://ftp.gnu.org/gnu/dejagnu/dejagnu-${VERSION}.tar.gz"
CHECKSUM="68c5208c58236eba447d7d6d1326b821"
DEPS="expect"
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir -v build
	cd       build

	../configure --prefix=$FAKEROOT/$NAME/usr
	makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
	makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi
}

_install()
{
	make install
	install -v -dm755  $FAKEROOT/$NAME/usr/share/doc/dejagnu-${VERSION}
	install -v -m644   doc/dejagnu.{html,txt} $FAKEROOT/$NAME/usr/share/doc/dejagnu-${VERSION}

	# Run tests (this test cannot be run before installation, so the tests
	# will always run)
	make -j${BUILD_JOBS} check
}

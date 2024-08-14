NAME="autoconf"
DESC="Programs for producing shell scripts that can automatically configure source code"
VERSION="2.72"
SOURCE="https://ftp.gnu.org/gnu/autoconf/autoconf-${VERSION}.tar.xz"
CHECKSUM="1be79f7106ab6767f18391c5e22be701"
DEPS=""
FLAGS="important test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix issues with new bash versions
	sed -e 's/SECONDS|/&SHLVL|/'               \
		-e '/BASH_ARGV=/a\        /^SHLVL=/ d' \
		-i.orig tests/local.at

	./configure --prefix=/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	TESTSUITEFLAGS=-j${BUILD_JOBS} make check
}

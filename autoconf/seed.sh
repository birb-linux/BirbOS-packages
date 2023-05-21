NAME="autoconf"
DESC="Programs for producing shell scripts that can automatically configure source code"
VERSION="2.71"
SOURCE="https://ftp.gnu.org/gnu/autoconf/autoconf-${VERSION}.tar.xz"
CHECKSUM="12cfa1687ffa2606337efe1a64416106"
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

	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	TESTSUITEFLAGS=-j${BUILD_JOBS} make check
}

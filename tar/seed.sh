NAME="tar"
DESC="Utility for creating tar archives as well as doing some other archive manipulation"
VERSION="1.35"
SOURCE="https://ftp.gnu.org/gnu/tar/tar-${VERSION}.tar.xz"
CHECKSUM="a2d8042658cfd8ea939e6d911eaf4152"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	FORCE_UNSAFE_CONFIGURE=1  \
		./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install
	make -C doc install-html docdir=$FAKEROOT/$NAME/usr/share/doc/tar-${VERSION}
}

#_test()
#{
#	# This test is considered dangerous to run as root
#	# but its okay in a partial install
#	make -j${BUILD_JOBS} check
#}

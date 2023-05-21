NAME="stow"
DESC="Symlink farm manager"
VERSION="2.3.1"
SOURCE="https://ftp.gnu.org/gnu/stow/stow-${VERSION}.tar.gz"
CHECKSUM="4dfd82b93bb6702d018b1d57e498a74d"
DEPS="perl"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr
}

_install()
{
	make -j${BUILD_JOBS}
}

_test()
{
	make test
}

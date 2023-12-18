NAME="git"
DESC="Distributed version control system"
VERSION="2.41.0"
SOURCE="https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.xz"
CHECKSUM="c1f58a12b891ad73927b8e4a3aa29c7b"
DEPS="curl zlib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --with-gitconfig=/etc/gitconfig \
            --with-python=python3

	make -j${BUILD_JOBS}
}

_install()
{
	make perllibdir=/usr/lib/perl5/5.36/site_perl DESTDIR=$FAKEROOT/$NAME install
}

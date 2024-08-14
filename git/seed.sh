NAME="git"
DESC="Distributed version control system"
VERSION="2.45.0"
SOURCE="https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.xz"
CHECKSUM="1daf15b08a3ef7bc58510ab75f5f1851"
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

NAME="dash"
DESC="Debian Almquist Shell"
VERSION="0.5.12"
SOURCE="http://gondor.apana.org.au/~herbert/dash/files/dash-${VERSION}.tar.gz"
CHECKSUM="57222b768b84003ea4b801e5d5e0e52b"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --bindir=$FAKEROOT/$NAME/bin --mandir=$FAKEROOT/$NAME/usr/share/man

	make -j$(nproc)
}

_install()
{
	make install
}

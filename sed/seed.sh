NAME="sed"
DESC="Stream editor"
VERSION="4.9"
SOURCE="https://ftp.gnu.org/gnu/sed/sed-${VERSION}.tar.xz"
CHECKSUM="6aac9b2dbafcd5b7a67a8a9bcb8036c3"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j$(nproc)
	make html
}

_install()
{
	make install
	install -d -m755           $FAKEROOT/$NAME/usr/share/doc/sed-${VERSION}
	install -m644 doc/sed.html $FAKEROOT/$NAME/usr/share/doc/sed-${VERSION}
}

_test()
{
	chown -Rv tester .
	su tester -c "PATH=$PATH make check"
}

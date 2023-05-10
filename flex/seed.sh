NAME="flex"
DESC="Utility for generating programs that recognize patterns in text"
VERSION="2.6.4"
SOURCE="https://github.com/westes/flex/releases/download/v${VERSION}/flex-${VERSION}.tar.gz"
CHECKSUM="2882e3179748cc9f9c23ec593d6adc8d"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --docdir=/usr/share/doc/flex-${VERSION} \
            --disable-static

	make -j${MAKEOPTS}
}

_test()
{
	make -j${MAKEOPTS} check
}

_install()
{
	make install

	# Create a symlink for legacy programs
	ln -sv flex $FAKEROOT/$NAME/usr/bin/lex
}

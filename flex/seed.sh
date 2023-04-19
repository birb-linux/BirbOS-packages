NAME="flex"
DESC="Utility for generating programs that recognize patterns in text"
VERSION="2.6.4"
SOURCE="https://github.com/westes/flex/releases/download/v${VERSION}/flex-${VERSION}.tar.gz"
CHECKSUM="2882e3179748cc9f9c23ec593d6adc8d"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --docdir=/usr/share/doc/flex-2.6.4 \
            --disable-static

	make -j$(nproc)
	make -j$(nproc) check
}

_install()
{
	make install

	# Create a symlink for legacy programs
	ln -sv flex /usr/bin/lex
}

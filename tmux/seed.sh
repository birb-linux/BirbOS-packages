NAME="tmux"
DESC="terminal multiplexer"
VERSION="3.3a"
SOURCE="https://github.com/tmux/tmux/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="8eee5883b9f6550fa4efaad0c9ec38f3"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j$(nproc)
}

_install()
{
	make install
}

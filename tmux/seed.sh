NAME="tmux"
DESC="terminal multiplexer"
VERSION="3.3a"
SOURCE="https://github.com/tmux/tmux/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="38b341836ed0bfe98d55d32f045d64dd"
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

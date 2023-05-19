NAME="magic-wormhole"
DESC="Get things from one computer to another, safely"
VERSION="0.12.0"
SOURCE="https://github.com/magic-wormhole/magic-wormhole/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="1289cfef3835c3ec0b16b0c8c23fd1a8"
DEPS="python3 wheel"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST magic-wormhole
}

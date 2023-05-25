NAME="pygments"
DESC="Generic syntax highlighter written in Python"
VERSION="2.15.1"
SOURCE="https://github.com/pygments/pygments/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="8f3575093e63ffaf2c9b605e35f3286d"
DEPS=""
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST Pygments
}

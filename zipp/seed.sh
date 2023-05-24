NAME="zipp"
DESC="A pathlib-compatible Zipfile object wrapper"
VERSION="3.15.0"
SOURCE="https://github.com/jaraco/zipp/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="eebf3e1c1a46b4f88acf6d77e1800a1d"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST $NAME
}

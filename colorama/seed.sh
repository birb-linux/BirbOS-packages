NAME="colorama"
DESC="Simple cross-platform colored terminal text in Python"
VERSION="0.4.6"
SOURCE="https://github.com/tartley/colorama/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="9854316552d41419b678d39af443a75f"
DEPS="hatchling"
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

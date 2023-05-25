NAME="pytz"
DESC="A library that brings the IANA tz database into Python"
VERSION="2022.7.1"
SOURCE="https://files.pythonhosted.org/packages/source/p/pytz/pytz-${VERSION}.tar.gz"
CHECKSUM="5acd981a81dcdc6aadddf4d7e5116b98"
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

NAME="urllib3"
DESC="Powerful, user-friendly HTTP client for Python"
VERSION="1.26.14"
SOURCE="https://files.pythonhosted.org/packages/source/u/urllib3/urllib3-${VERSION}.tar.gz"
CHECKSUM="7e018ce0f7cddc0560fd4541b5febf06"
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

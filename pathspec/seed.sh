NAME="pathspec"
DESC="Utility library for pattern matching of file paths"
VERSION="0.10.3"
SOURCE="https://files.pythonhosted.org/packages/source/p/pathspec/pathspec-${VERSION}.tar.gz"
CHECKSUM="d89408b52aff020ac768a14c0ef1c7de"
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

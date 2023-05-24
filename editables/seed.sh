NAME="editables"
DESC="Python library for creating “editable wheels”"
VERSION="0.3"
SOURCE="https://files.pythonhosted.org/packages/source/e/editables/editables-${VERSION}.tar.gz"
CHECKSUM="e91709fbb0ef586cb7b785042068ab67"
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

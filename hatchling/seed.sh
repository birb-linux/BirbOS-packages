NAME="hatchling"
DESC="An extensible, standards compliant build backend for python modules"
VERSION="1.12.2"
SOURCE="https://files.pythonhosted.org/packages/source/h/hatchling/hatchling-${VERSION}.tar.gz"
CHECKSUM="5a6e2fd0c877feea7e71b9d72bbdbed9"
DEPS="editables packaging pathspec pluggy"
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

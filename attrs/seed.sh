NAME="attrs"
DESC="Theme for the sphinx documentation system"
VERSION="22.2.0"
SOURCE="https://files.pythonhosted.org/packages/source/a/attrs/attrs-${VERSION}.tar.gz"
CHECKSUM="eff16b3bbd0d9b72e118cca83a19d380"
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

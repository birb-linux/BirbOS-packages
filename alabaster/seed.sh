NAME="alabaster"
DESC="Theme for the sphinx documentation system"
VERSION="0.7.13"
SOURCE="https://files.pythonhosted.org/packages/source/a/alabaster/alabaster-${VERSION}.tar.gz"
CHECKSUM="2e05a5f4fe5a8b95e5e576cbf4a5d503"
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

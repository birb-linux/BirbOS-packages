NAME="packaging"
DESC="Utilities that implement the interoperability specifications which have clearly one correct behaviour"
VERSION="23.0"
SOURCE="https://files.pythonhosted.org/packages/source/p/packaging/packaging-${VERSION}.tar.gz"
CHECKSUM="5c7b22d9258e8132c16cee4f230d8252"
DEPS="flit-core"
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

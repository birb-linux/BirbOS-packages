NAME="idna"
DESC="Module that provides support for the Internationalized Domain Names in Applications (IDNA) protocol"
VERSION="3.4"
SOURCE="https://files.pythonhosted.org/packages/source/i/idna/idna-${VERSION}.tar.gz"
CHECKSUM="13ea24e076212b6baae1135a116d1e0e"
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

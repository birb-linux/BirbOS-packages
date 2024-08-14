NAME="flit-core"
DESC="Distribution-building parts of Flit (a packaging tool for simple Python modules)"
VERSION="3.9.0"
SOURCE="https://pypi.org/packages/source/f/flit-core/flit_core-${VERSION}.tar.gz"
CHECKSUM="3bc52f1952b9a78361114147da63c35b"
DEPS="python3"
FLAGS="python important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd flit_core-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST flit_core
}

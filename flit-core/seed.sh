NAME="flit-core"
DESC="Distribution-building parts of Flit (a packaging tool for simple Python modules)"
VERSION="3.8.0"
SOURCE="https://pypi.org/packages/source/f/flit-core/flit_core-${VERSION}.tar.gz"
CHECKSUM="7c41da13273f7787709a24f74e0f5a99"
DEPS=""
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd flit_core-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/dist --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/dist flit_core
}

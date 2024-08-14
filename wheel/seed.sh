NAME="wheel"
DESC="Python library that is the reference implementation of the Python wheel packaging standard"
VERSION="0.43.0"
SOURCE="https://pypi.org/packages/source/w/wheel/wheel-${VERSION}.tar.gz"
CHECKSUM="387af15d51367a19d834d6db413547d0"
DEPS="python3 flit-core"
FLAGS="python important"

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
	pip3 install --no-index --find-links=$FAKEROOT/$NAME/$PYTHON_DIST wheel
}

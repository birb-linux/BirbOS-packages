NAME="sphinxcontrib-jsmath"
DESC="Sphinx extension which renders display math in HTML via JavaScript"
VERSION="1.0.1"
SOURCE="https://github.com/sphinx-doc/sphinxcontrib-jsmath/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="63b128d164e727722f48d388a1b57dde"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST sphinxcontrib-jsmath
}

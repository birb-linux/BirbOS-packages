NAME="sphinxcontrib-devhelp"
DESC="Sphinx extension which outputs Devhelp document"
VERSION="1.0.2"
SOURCE="https://github.com/sphinx-doc/sphinxcontrib-devhelp/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="5ff568fed7b7e2a1ab0e09b874c413de"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST sphinxcontrib-devhelp
}

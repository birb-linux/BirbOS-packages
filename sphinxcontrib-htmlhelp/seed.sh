NAME="sphinxcontrib-htmlhelp"
DESC="Sphinx extension which renders HTML help files"
VERSION="2.0.1"
SOURCE="https://github.com/sphinx-doc/sphinxcontrib-htmlhelp/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="6254d5e92fc377b98f516ac47965b8ef"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST sphinxcontrib-htmlhelp
}

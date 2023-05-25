NAME="sphinxcontrib-qthelp"
DESC="Sphinx extension which outputs QtHelp document"
VERSION="1.0.3"
SOURCE="https://github.com/sphinx-doc/sphinxcontrib-qthelp/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="2cf0be6419124f8ed6dc72e39f73da8c"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST sphinxcontrib-qthelp
}

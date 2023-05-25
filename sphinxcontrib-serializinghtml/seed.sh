NAME="sphinxcontrib-serializinghtml"
DESC="Sphinx extension which outputs 'serialized' HTML files (json and pickle)"
VERSION="1.1.5"
SOURCE="https://github.com/sphinx-doc/sphinxcontrib-serializinghtml/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="0196750dd6e4669ae5c9e32b77c35915"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST sphinxcontrib-serializinghtml
}

NAME="sphinxcontrib-applehelp"
DESC="Sphinx extension which outputs Apple help books"
VERSION="1.0.4"
SOURCE="https://github.com/sphinx-doc/sphinxcontrib-applehelp/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="b254d0ab978618ebda44e86955174e4b"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST sphinxcontrib-applehelp
}

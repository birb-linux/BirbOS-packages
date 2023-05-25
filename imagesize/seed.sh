NAME="imagesize"
DESC="Package that analyzes image file headers and returns the image size and DPI"
VERSION="1.4.1"
SOURCE="https://files.pythonhosted.org/packages/source/i/imagesize/imagesize-${VERSION}.tar.gz"
CHECKSUM="5a40586a25c07e1a8f16f6267252c321"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST $NAME
}

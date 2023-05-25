NAME="jinja"
DESC="A very fast and expressive template engine"
VERSION="3.1.2"
SOURCE="https://github.com/pallets/jinja/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="bd31ea57df9229c695f7ef755bfcda43"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST Jinja2
}

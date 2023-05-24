NAME="chardet"
DESC="Universal character encoding detector"
VERSION="5.1.0"
SOURCE="https://files.pythonhosted.org/packages/source/c/chardet/chardet-${VERSION}.tar.gz"
CHECKSUM="394bd03d7a258d2771040bfbd5a7bf66"
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

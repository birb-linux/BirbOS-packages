NAME="commonmark"
DESC="Python parser for the CommonMark Markdown specification"
VERSION="0.9.1"
SOURCE="https://files.pythonhosted.org/packages/source/c/commonmark/commonmark-${VERSION}.tar.gz"
CHECKSUM="cd1dc70c4714d9ed4117a40490c25e00"
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

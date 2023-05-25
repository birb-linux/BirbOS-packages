NAME="charset-normalizer"
DESC="Library that helps reading text from an unknown character encoding"
VERSION="3.0.1"
SOURCE="https://files.pythonhosted.org/packages/source/c/charset-normalizer/charset-normalizer-${VERSION}.tar.gz"
CHECKSUM="12ee1c8bedbfba84e99db46d5d94f411"
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

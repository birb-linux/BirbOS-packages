NAME="snowballstemmer"
DESC="Small string processing language for creating stemming algorithms"
VERSION="2.2.0"
SOURCE="https://files.pythonhosted.org/packages/source/s/snowballstemmer/snowballstemmer-${VERSION}.tar.gz"
CHECKSUM="4332ddc7bbee0f344a03915b2ad59a54"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST snowballstemmer
}

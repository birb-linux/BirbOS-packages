NAME="pluggy"
DESC="Pluggy enables function hooking so a user can build “pluggable” systems"
VERSION="1.0.0"
SOURCE="https://files.pythonhosted.org/packages/source/p/pluggy/pluggy-${VERSION}.tar.gz"
CHECKSUM="daa6fddfb6cd364f3c82e52098911e4b"
DEPS="setuptools-scm"
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

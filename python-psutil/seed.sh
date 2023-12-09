NAME="python-psutil"
DESC="Cross-platform lib for process and system monitoring in Python"
VERSION="5.9.6"
SOURCE="https://files.pythonhosted.org/packages/2d/01/beb7331fc6c8d1c49dd051e3611379bfe379e915c808e1301506027fce9d/psutil-${VERSION}.tar.gz"
CHECKSUM="eec35090e7474e471a12f0dd16c981f9"
DEPS="python3"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd psutil-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST $NAME
}

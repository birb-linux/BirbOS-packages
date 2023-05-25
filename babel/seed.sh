NAME="babel"
DESC="Integrated collection of utilities that assist in internationalizing and localizing Python applications"
VERSION="2.11.0"
SOURCE="https://files.pythonhosted.org/packages/source/B/Babel/Babel-${VERSION}.tar.gz"
CHECKSUM="9ee7784fd452d456206ecd3a12694010"
DEPS="pytz"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd Babel-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST $NAME
}

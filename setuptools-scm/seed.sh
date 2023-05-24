NAME="setuptools-scm"
DESC="Package used to extract Python package versions from git or hg metadata instead of declaring them"
VERSION="7.1.0"
SOURCE="https://files.pythonhosted.org/packages/source/s/setuptools_scm/setuptools_scm-${VERSION}.tar.gz"
CHECKSUM="158dc741637fb4fa4b955c62bd2c08be"
DEPS="packaging typing-extensions"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd setuptools_scm-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST setuptools_scm
}

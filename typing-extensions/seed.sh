NAME="typing-extensions"
DESC="Module that allows using new type system features not yet defined on the Python version in use on the system"
VERSION="4.4.0"
SOURCE="https://files.pythonhosted.org/packages/source/t/typing_extensions/typing_extensions-${VERSION}.tar.gz"
CHECKSUM="5cfcb56ea6fc4972c3600c0030f4d136"
DEPS="flit-core"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd typing_extensions-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST typing_extensions
}

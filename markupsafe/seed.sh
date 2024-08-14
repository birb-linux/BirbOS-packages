NAME="markupsafe"
DESC="Python module that implements a XML/HTML/XHTML Markup safe string"
VERSION="2.1.5"
SOURCE="https://files.pythonhosted.org/packages/source/M/MarkupSafe/MarkupSafe-${VERSION}.tar.gz"
CHECKSUM="8fe7227653f2fb9b1ffe7f9f2058998a"
DEPS=""
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd MarkupSafe-${VERSION}
}

_build()
{
	pip3 wheel -w $PYTHON_PREFIX --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --find-links $PYTHON_PREFIX --no-cache-dir --no-user markupsafe
}

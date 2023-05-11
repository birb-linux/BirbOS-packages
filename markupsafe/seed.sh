NAME="markupsafe"
DESC="Python module that implements a XML/HTML/XHTML Markup safe string"
VERSION="2.1.2"
SOURCE="https://files.pythonhosted.org/packages/source/M/MarkupSafe/MarkupSafe-${VERSION}.tar.gz"
CHECKSUM="02f337b98aef11bd0fee9c5ae860173b"
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

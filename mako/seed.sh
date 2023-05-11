NAME="mako"
DESC="Hyperfast and lightweight templating for the Python platform"
VERSION="1.2.4"
SOURCE="https://files.pythonhosted.org/packages/source/M/Mako/Mako-${VERSION}.tar.gz"
CHECKSUM="651f365616611fcd4f2702a9002e2195"
DEPS=""
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd Mako-${VERSION}
}

_build()
{
	pip3 wheel -w $PYTHON_PREFIX --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --find-links $PYTHON_PREFIX --no-cache-dir --no-user Mako
}

NAME="gprof2dot"
DESC="Converts profiling output to a dot graph"
VERSION="2022.07.29"
SOURCE="https://github.com/jrfonseca/gprof2dot/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="9d6ddd06b4cd5036dc1c9e7a6b28b7ad"
DEPS="graphviz"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST gprof2dot
}

NAME="importlib-metadata"
DESC="Backport of the importlib.metadata module"
VERSION="6.6.0"
SOURCE="https://github.com/python/importlib_metadata/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="861c75ca8d33869e9daa03a031f055c6"
DEPS=""
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd importlib_metadata-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST importlib_metadata
}

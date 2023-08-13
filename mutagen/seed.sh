NAME="mutagen"
DESC="Python module for handling audio metadata"
VERSION="1.46.0"
SOURCE="https://github.com/quodlibet/mutagen/releases/download/release-${VERSION}/mutagen-${VERSION}.tar.gz"
CHECKSUM="648c9f38b8ef46ffb0d5135524650b87"
DEPS=""
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
	pip3 install --no-index --find-links=$FAKEROOT/$NAME/$PYTHON_DIST wheel
}

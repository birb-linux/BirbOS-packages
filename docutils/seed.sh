NAME="docutils"
DESC="A set of Python modules and programs for processing plaintext docs into formats such as HTML, XML, or LaTeX"
VERSION="0.19"
SOURCE="https://downloads.sourceforge.net/docutils/docutils-${VERSION}.tar.gz"
CHECKSUM="0afa992a6e93db892107c3f087d0d9df"
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
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST docutils
}

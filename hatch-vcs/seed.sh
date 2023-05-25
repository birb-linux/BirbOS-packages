NAME="hatch-vcs"
DESC="Hatch plugin for versioning with several VCS"
VERSION="0.3.0"
SOURCE="https://files.pythonhosted.org/packages/source/h/hatch-vcs/hatch_vcs-${VERSION}.tar.gz"
CHECKSUM="c2f2cbe6851b7b2969cb4aa24c4b9b2f"
DEPS="hatchling setuptools-scm"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd hatch_vcs-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST hatch_vcs
}

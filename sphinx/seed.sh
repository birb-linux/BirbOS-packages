NAME="sphinx"
DESC="The Sphinx documentation generator"
VERSION="7.0.1"
SOURCE="https://github.com/sphinx-doc/sphinx/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="1bb87f2b84b2fd3401fff53cc9681209"
DEPS="sphinxcontrib-applehelp sphinxcontrib-devhelp sphinxcontrib-jsmath sphinxcontrib-htmlhelp sphinxcontrib-serializinghtml sphinxcontrib-qthelp jinja pygments docutils snowballstemmer babel alabaster imagesize requests packaging importlib-metadata colorama"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Patch the version requirement for sphinxcontrib-serializinghtml
	# because for some reason its not matching the correctly installed
	# version of the package in question
	sed -i 's/"sphinxcontrib-serializinghtml>=1.1.5"/"sphinxcontrib-serializinghtml>=1.1.4"/' pyproject.toml

	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST sphinx
}

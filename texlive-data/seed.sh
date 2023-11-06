NAME="texlive-data"
DESC="Separately provided scripts, documentation, fonts, and various other files required for a texlive environment"
YEAR="2023"
VERSION="20230313"
SOURCE="https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${YEAR}/texlive-${VERSION}-texmf.tar.xz"
CHECKSUM="704fb39c69e3710b8e9e9158cec5047a"
DEPS=""
FLAGS=""

_setup()
{
	printf ""
}

_build()
{
	printf ""
}

_install()
{
	cd "$FAKEROOT/$NAME/usr"
	tar -xf $DISTFILES/$(basename $SOURCE)
}

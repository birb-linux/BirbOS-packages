NAME="koruri"
DESC="Japanese TrueType font obtained by mixing M+ FONTS and Open Sans"
VERSION="20210720"
SOURCE="https://github.com/Koruri/Koruri/releases/download/${VERSION}/Koruri-${VERSION}.tar.xz"
CHECKSUM="e2c638adef79008f6abab28e7313d969"
DEPS="fontconfig"
FLAGS="font"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
}

_build()
{
	printf ""
}

_install()
{
	cp -v *.ttf $FAKEROOT/$NAME/usr/share/fonts/TTF/
}

NAME="mononoki-nerd"
DESC="A font for programming and code review"
VERSION="3.1.1"
SOURCE="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Mononoki.zip"
CHECKSUM="addfef44ab94ef36a125cdceb227356e"
DEPS="unzip"
FLAGS="font"

_setup()
{
	unzip $DISTFILES/$(basename $SOURCE)
}

_build()
{
	printf ""
}

_install()
{
	cp -v *.ttf $FAKEROOT/$NAME/usr/share/fonts/TTF/
}

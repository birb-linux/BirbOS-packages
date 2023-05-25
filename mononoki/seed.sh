NAME="mononoki"
DESC="A font for programming and code review"
VERSION="1.6"
SOURCE="https://github.com/madmalik/mononoki/releases/download/${VERSION}/mononoki.zip"
CHECKSUM="5ad3d3829730bb202a7f26ba58fdea08"
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

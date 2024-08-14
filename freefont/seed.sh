# shellcheck disable=SC2034
NAME="freefont"
DESC="Family of free fonts"
VERSION="20120503"
SOURCE="https://ftp.gnu.org/gnu/freefont/freefont-ttf-${VERSION}.zip"
CHECKSUM="879b76d2e3c8003d567b555743f39154"
DEPS="unzip"
FLAGS="font"

_setup()
{
	unzip "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	printf ""
}

_install()
{
	cp -v ./*.ttf "$FAKEROOT/$NAME/usr/share/fonts/TTF/"
}

NAME="runescape"
DESC="Runescape 3 launcher"
VERSION="2.2.11"
SOURCE="https://content.runescape.com/downloads/ubuntu/pool/non-free/r/runescape-launcher/runescape-launcher_${VERSION}_amd64.deb"
CHECKSUM="31970349fc9745e66097e0a68aa22912"
DEPS="openssl-legacy gtk+-2"
FLAGS="proprietary"

_setup()
{
	ar x $DISTFILES/$(basename $SOURCE)
}

_build()
{
	tar -xf ./data.tar.xz
}

_install()
{
	cp -vr ./usr/* $FAKEROOT/$NAME/usr/
}

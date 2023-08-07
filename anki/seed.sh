NAME="anki"
DESC="Anki is a program which makes remembering things easy"
VERSION="2.1.65"
SOURCE="https://github.com/ankitects/anki/releases/download/${VERSION}/anki-${VERSION}-linux-qt6.tar.zst"
CHECKSUM="8e6bd0c53d1fa63a451ad4e931e3c5f3"
DEPS="xcb-util-cursor xcb-util-wm xcb-util-image xcb-util-renderutil mit-kerberos5"
FLAGS="proprietary"

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
	# Copy the anki binary package to /opt
	mkdir -p $FAKEROOT/$NAME/opt/anki
	cp -r ./anki-${VERSION}-linux-qt6/* $FAKEROOT/$NAME/opt/anki/

	ln -srv $FAKEROOT/$NAME/opt/anki/anki $FAKEROOT/$NAME/usr/bin/anki
}

NAME="signal-desktop"
DESC="A private messenger"
VERSION="6.40.0"
SOURCE="https://updates.signal.org/desktop/apt/pool/s/signal-desktop-beta/signal-desktop-beta_${VERSION}-beta.2_amd64.deb"
CHECKSUM="9b315b8a1587df8074714cbb7da0a66b"
DEPS="libnotify libxtst nss xdg-utils libxss cups"
FLAGS="proprietary"

_setup()
{
	ar x $DISTFILES/$(basename $SOURCE)
}

_build()
{
	tar -xvf data.tar.xz
}

_install()
{
	mkdir -p $FAKEROOT/$NAME/opt
	cp -r ./opt/* $FAKEROOT/$NAME/opt/
	cp -r ./usr/* $FAKEROOT/$NAME/usr/

	ln -sr $FAKEROOT/$NAME/opt/Signal\ Beta/signal-desktop-beta $FAKEROOT/$NAME/usr/bin/signal-desktop
}

NAME="papirus-icon-theme"
DESC="Pixel perfect icon theme for Linux"
VERSION="20231101"
SOURCE="https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="2c42e8eb7477055ed09e6a700baa4a6f"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	printf  ""
}

_install()
{
	mkdir -p $FAKEROOT/$NAME/usr/share/icons
	cp -vr ./{Papirus,Papirus-Dark,Papirus-Light} $FAKEROOT/$NAME/usr/share/icons/
	# make DESTDIR=$FAKEROOT/$NAME install
}

NAME="steam-launcher"
DESC="Video game digital distribution service and storefront from Valve"
VERSION="1.0.0.76"
SOURCE="https://repo.steampowered.com/steam/archive/stable/steam_${VERSION}.tar.gz"
CHECKSUM="9db32c129bac8a40080d97888f028c3b"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
}

_build()
{
	printf ""
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr install
}

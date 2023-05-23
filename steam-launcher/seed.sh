NAME="steam-launcher"
DESC="Video game digital distribution service and storefront from Valve"
VERSION="1.0.0.76"
SOURCE="https://repo.steampowered.com/steam/archive/stable/steam_${VERSION}.tar.gz"
CHECKSUM="9db32c129bac8a40080d97888f028c3b"
DEPS="pciutils"
FLAGS="proprietary"

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

	# Fix absolute symlinks
	ln -sfvr $FAKEROOT/$NAME/usr/lib/steam/bin_steam.sh $FAKEROOT/$NAME/usr/bin/steam
	ln -sfvr $FAKEROOT/$NAME/usr/lib/steam/bin_steamdeps.sh $FAKEROOT/$NAME/usr/bin/steamdeps
}

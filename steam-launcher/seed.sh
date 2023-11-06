NAME="steam-launcher"
DESC="Video game digital distribution service and storefront from Valve"
VERSION="1.0.0.76"
SOURCE="https://repo.steampowered.com/steam/archive/stable/steam_${VERSION}.tar.gz"
CHECKSUM="9db32c129bac8a40080d97888f028c3b"
DEPS="pciutils lsof xdg-user-dirs"
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

	# Create a runner script that fixes an issue with glibc
	# To use this script add `steam_run %command` to the games launch options
	cat >> $FAKEROOT/$NAME/usr/bin/steam_run << "EOF"
#!/bin/sh
if [ $# -eq 0 ]
then
	echo "This script is meant to be used as an launch option for steam games."
	echo "Usage: steam_run %command%"
	exit 1
fi

export LD_PRELOAD="/usr/lib/libc.so.6 /usr/lib32/libc.so.6"
"$@"
EOF
	chmod +x $FAKEROOT/$NAME/usr/bin/steam_run
}

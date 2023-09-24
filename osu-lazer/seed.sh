NAME="osu-lazer"
DESC="rhythm is just a *click* away!"
VERSION="2023.914.0"
SOURCE="https://github.com/ppy/osu/releases/download/${VERSION}/osu.AppImage"
CHECKSUM="1f33c393496fdd068ce5e41e3ad6ae37"
DEPS="pulseaudio alsa-plugins fuse2"
FLAGS="proprietary"

_setup()
{
	printf ""
}

_build()
{
	printf ""
}

_install()
{
	cp -v $DISTFILES/$(basename $SOURCE) $FAKEROOT/$NAME/usr/bin/osu-lazer
	chmod +x $FAKEROOT/$NAME/usr/bin/osu-lazer
}

NAME="screenrecord"
DESC="Wrapper script for ffmpeg that should make screen recording without OBS a bit easier"
VERSION="1.0.0"
SOURCE="https://github.com/birb-linux/screenrecord/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="ddf0747d0a629e45cd0559c0bf98e28c"
DEPS="ffmpeg pulseaudio"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}

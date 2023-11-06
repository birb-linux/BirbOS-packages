NAME="screenrecord"
DESC="Wrapper script for ffmpeg that should make screen recording without OBS a bit easier"
VERSION="1.0.0"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/birb-linux/screenrecord/archive/${VERSION}.tar.gz"
CHECKSUM="be50322154ae18f7617a68bae93565a1"
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

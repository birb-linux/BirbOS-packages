NAME="yt-dlp"
DESC="A youtube-dl fork with additional features and fixes"
VERSION="2023.10.13"
SOURCE="https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp.tar.gz"
CHECKSUM="91b9c05e543be09278e189f9348b05db"
DEPS="ffmpeg"
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
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}

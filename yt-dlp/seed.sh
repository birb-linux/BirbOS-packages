NAME="yt-dlp"
DESC="A youtube-dl fork with additional features and fixes"
VERSION="2023.12.30"
SOURCE="https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp.tar.gz"
CHECKSUM="4a32db6bfe42f651ed9ba4feffc43fec"
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

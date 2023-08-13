NAME="yt-dlp"
DESC="A youtube-dl fork with additional features and fixes"
VERSION="2023.07.06"
SOURCE="https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp.tar.gz"
CHECKSUM="20ff3cad19bda18fa3bf9e8492222645"
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

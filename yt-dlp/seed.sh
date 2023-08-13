NAME="yt-dlp"
DESC="A youtube-dl fork with additional features and fixes"
VERSION="2023.07.06"
SOURCE="https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp.tar.gz"
CHECKSUM="20ff3cad19bda18fa3bf9e8492222645"
DEPS="ffmpeg mutagen"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST $NAME
}

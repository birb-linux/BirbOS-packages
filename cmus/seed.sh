NAME="cmus"
DESC="Small, fast and powerful console music player for Unix-like operating systems"
VERSION="2.9.1"
SOURCE="https://github.com/cmus/cmus/archive/v${VERSION}.tar.gz"
CHECKSUM="914ea4f79827174f825e9e7ce3880c44"
DEPS="pulseaudio faac flac libmad opus libvorbis"
FLAGS=""
NOTES="cmus has a lot of optional dependencies. If there's some specific audio format that you need, please installed the required library for that and reinstall cmus. The most common formats (mp3, opus etc.) should be covered by the dependencies"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure prefix=/usr \
		CONFIG_AAC=y       \
		CONFIG_FLAC=y      \
		CONFIG_MAD=y       \
		CONFIG_OPUS=y      \
		CONFIG_PULSE=y     \
		CONFIG_VORBIS=y

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

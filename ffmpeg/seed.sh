NAME="ffmpeg"
DESC="A solution to record, convert and stream audio and video"
VERSION="5.1.2"
SOURCE="https://ffmpeg.org/releases/ffmpeg-${VERSION}.tar.xz"
CHECKSUM="fa847c43407315c27231b9f883e62c0e"
DEPS="libass fdk-aac freetype lame libtheora libvorbis libvpx opus x264 x265 nasm alsa-lib libva libvdpau sdl2 openssl pulseaudio"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	patch -Np1 -i $PKG_PATH/ffmpeg-${VERSION}-chromium_method-1.patch

	sed -i 's/-lflite"/-lflite -lasound"/' configure

	./configure --prefix=/usr \
				--enable-gpl         \
				--enable-version3    \
				--enable-nonfree     \
				--disable-static     \
				--enable-shared      \
				--disable-debug      \
				--enable-libass      \
				--enable-libfdk-aac  \
				--enable-libfreetype \
				--enable-libmp3lame  \
				--enable-libopus     \
				--enable-libtheora   \
				--enable-libvorbis   \
				--enable-libvpx      \
				--enable-libx264     \
				--enable-libx265     \
				--enable-openssl     \
				--enable-libpulse    \
				--docdir=/usr/share/doc/ffmpeg-${VERSION}

	make -j${BUILD_JOBS}

	gcc tools/qt-faststart.c -o tools/qt-faststart
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	install -v -m755    tools/qt-faststart $FAKEROOT/$NAME/usr/bin
	install -v -m755 -d           $FAKEROOT/$NAME/usr/share/doc/ffmpeg-${VERSION}
	install -v -m644    doc/*.txt $FAKEROOT/$NAME/usr/share/doc/ffmpeg-${VERSION}
}

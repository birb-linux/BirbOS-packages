NAME="pavucontrol"
DESC="PulseAudio Volume Control (pavucontrol) is a simple GTK based volume control tool (mixer) for the PulseAudio sound server"
VERSION="5.0"
SOURCE="https://freedesktop.org/software/pulseaudio/pavucontrol/pavucontrol-${VERSION}.tar.xz"
CHECKSUM="a4a5dc51dcf4d912443faf3fe8d32b55"
DEPS="gtkmm json-glib libcanberra libsigc++ pulseaudio"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --docdir=$FAKEROOT/$NAME/usr/share/doc/pavucontrol-${VERSION}
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

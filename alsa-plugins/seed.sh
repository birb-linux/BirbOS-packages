NAME="alsa-plugins"
DESC="Plugins for various audio libraries and sound servers"
VERSION="1.2.7.1"
SOURCE="https://www.alsa-project.org/files/pub/plugins/alsa-plugins-${VERSION}.tar.bz2"
CHECKSUM="8fb7e05b84c87f30655a8997a9a983d1"
DEPS="alsa-lib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --sysconfdir=/etc

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

NAME="xfdesktop"
DESC="Desktop manager for the Xfce Desktop Environment"
VERSION="4.18.1"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://archive.xfce.org/src/xfce/xfdesktop/${SHORT_VERSION}/xfdesktop-${VERSION}.tar.bz2"
CHECKSUM="e675c2989436dc724fef402d1db0125d"
DEPS="exo libwnck libnotify startup-notification"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

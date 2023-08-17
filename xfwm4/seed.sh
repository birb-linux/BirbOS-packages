NAME="xfwm4"
DESC="Window manager for Xfce"
VERSION="4.18.0"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://archive.xfce.org/src/xfce/xfwm4/${SHORT_VERSION}/xfwm4-${VERSION}.tar.bz2"
CHECKSUM="181415e457c86124fa5f8aa5d715b967"
DEPS="libwnck libxfce4ui startup-notification"
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

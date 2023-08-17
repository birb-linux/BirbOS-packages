NAME="sudo-kaomoji"
DESC="Generates cute kaomoji prompts for sudo"
VERSION="1.0.0"
SOURCE="https://github.com/Toasterbirb/sudo-kaomoji/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="d0b5d52f241a61ebf5cd8765e87d782b"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install

	mkdir -p $FAKEROOT/$NAME/etc/profile.d
	cat >> $FAKEROOT/$NAME/etc/profile.d/sudo-kaomoji.sh << "EOF"
# Set the sudo prompt to use sudo-kaomoji
export SUDO_PROMPT="$(sudo-kaomoji)"
EOF
}

NAME="sudo-kaomoji"
DESC="Generates cute kaomoji prompts for sudo"
VERSION="1.1.0"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/birb-linux/sudo-kaomoji/archive/${VERSION}.tar.gz"
CHECKSUM="ff1c621d0af87f156f30dc5e4494d9c6"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
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

NAME="dmenu-bookmarks"
DESC="Bookmark manager for Firefox built around dmenu"
VERSION="1.0.0"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/toasterbirb/dmenu-bookmarks/archive/${VERSION}.tar.gz"
CHECKSUM="d92af19cb532cb279353a49f1dfbe12e"
DEPS="dmenu mononoki"
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

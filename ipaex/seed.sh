NAME="ipaex"
DESC="IPAex Fonts are JIS X 0213:2012 compliant OpenType fonts based on TrueType outlines"
VERSION="00401"
SOURCE="https://moji-or-jp.translate.goog/wp-content/ipafont/IPAexfont/IPAexfont${VERSION}.zip"
CHECKSUM="57f2631833c1049ea89320971cc74ce5"
DEPS="unzip"
FLAGS="font"

_setup()
{
	unzip $DISTFILES/$(basename $SOURCE)
	cd IPAexfont${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	cp -v *.ttf $FAKEROOT/$NAME/usr/share/fonts/TTF/
}

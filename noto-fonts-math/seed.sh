NAME="noto-fonts-math"
DESC="Noto fonts for mathematical notation"
VERSION="2.539"
SOURCE="https://github.com/notofonts/math/releases/download/NotoSansMath-v${VERSION}/NotoSansMath-v${VERSION}.zip"
CHECKSUM="77be110cb77d25428da0976b3b337d95"
DEPS="unzip"
FLAGS="font"

_setup()
{
	set +e
	unzip $DISTFILES/$(basename $SOURCE)
	set -e
}

_build()
{
	printf ""
}

_install()
{
	cp -v ./NotoSansMath/full/ttf/*.ttf $FAKEROOT/$NAME/usr/share/fonts/TTF/
	cp -v ./NotoSansMath/full/otf/*.otf $FAKEROOT/$NAME/usr/share/fonts/OTF/
}

NAME="noto-fonts-jp"
DESC="Noto fonts for Japanese"
VERSION="2.002"
SOURCE="https://github.com/notofonts/noto-cjk/releases/download/Serif${VERSION}/07_NotoSerifCJKjp.zip"
CHECKSUM="47023424fd2ce07d61efe99c4001e60f"
DEPS="unzip"
FLAGS="font"

_setup()
{
	unzip $DISTFILES/$(basename $SOURCE)
}

_build()
{
	printf ""
}

_install()
{
	cp -vr ./OTF/Japanese $FAKEROOT/$NAME/usr/share/fonts/OTF/
}

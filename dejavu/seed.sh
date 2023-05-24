NAME="dejavu"
DESC="The DejaVu fonts are a font family based on the Bitstream Vera Fonts"
VERSION="2.37"
SOURCE="https://downloads.sourceforge.net/project/dejavu/dejavu/${VERSION}/dejavu-lgc-fonts-ttf-${VERSION}.tar.bz2"
CHECKSUM="41e9905470956bf74d238b76738d723f"
DEPS=""
FLAGS="font"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd dejavu-lgc-fonts-ttf-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	cp -v ./ttf/* $FAKEROOT/$NAME/usr/share/fonts/TTF/
}

NAME="luatex"
DESC="Extended version of pdfTeX using Lua as an embedded scripting language"
VERSION="1.17.0"
SOURCE="https://gitlab.lisn.upsaclay.fr/texlive/luatex/-/archive/${VERSION}/luatex-${VERSION}.tar.gz"
CHECKSUM="aeadf30e41a2d28e40f83c782758c15c"
DEPS="which lua"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./build.sh --parallel
}

_install()
{
	# make DESTDIR=$FAKEROOT/$NAME install
	cp -v build/texk/web2c/luatex "$FAKEROOT/$NAME/usr/bin/luatex"
	ln -srfv "$FAKEROOT/$NAME/usr/bin/luatex" "$FAKEROOT/$NAME/usr/bin/{texlua,texluac,lualatex}"
}

NAME="lua-language-server"
DESC="A language server that offers Lua language support - programmed in Lua"
VERSION="3.7.3"
SOURCE="https://github.com/LuaLS/lua-language-server/releases/download/${VERSION}/lua-language-server-${VERSION}-submodules.zip"
CHECKSUM="f350af65f975970b2d9322c47b0fdd34"
DEPS="unzip ninja"
FLAGS=""

_setup()
{
	unzip $DISTFILES/$(basename $SOURCE)
}

_build()
{
	./make.sh
}

_install()
{
	# Thank you https://archlinux.org/packages/extra/x86_64/lua-language-server
	# for helping with this package <3

	mkdir -p $FAKEROOT/$NAME/usr/lib/$NAME
	cp -vr {bin,locale,meta,script} $FAKEROOT/$NAME/usr/lib/$NAME/
	cp -v {debugger,main}.lua $FAKEROOT/$NAME/usr/lib/$NAME/

	cat >> $FAKEROOT/$NAME/usr/bin/lua-language-server << EOF
#!/usr/bin/env sh
TMPPATH="/tmp/lua-language-server-\$(id -u)"
mkdir -p "\$TMPPATH"
INSTANCEPATH=\$(mktemp -d "\$TMPPATH/instance.XXXX")
DEFAULT_LOGPATH="\$INSTANCEPATH/log"
DEFAULT_METAPATH="\$INSTANCEPATH/meta"

exec /usr/lib/lua-language-server/bin/lua-language-server -E /usr/lib/lua-language-server/main.lua \
  --logpath="\$DEFAULT_LOGPATH" --metapath="\$DEFAULT_METAPATH" \
  "\$@"
EOF

	chmod +x $FAKEROOT/$NAME/usr/bin/lua-language-server 
}

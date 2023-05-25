NAME="asciidoctor"
DESC="Fast, open source text processor and publishing toolchain for converting AsciiDoc content to HTML5, DocBook, PDF, and other formats"
VERSION="2.0.18"
SOURCE="https://github.com/asciidoctor/asciidoctor/archive/v${VERSION}/asciidoctor-${VERSION}.tar.gz"
CHECKSUM="30a020f2db5f29a90bd2249bf3ad1f08"
DEPS="ruby"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	gem build asciidoctor.gemspec
}

_install()
{
	mkdir -p $FAKEROOT/$NAME/usr/lib/ruby/gems/3.2.0
	gem install --install-dir $FAKEROOT/$NAME/usr/lib/ruby/gems/3.2.0 asciidoctor-${VERSION}.gem
	install -vm644 man/asciidoctor.1 $FAKEROOT/$NAME/usr/share/man/man1
}

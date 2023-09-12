NAME="seclists"
DESC="Collection of multiple types of lists used during security assessments"
VERSION="2023.2"
SOURCE="https://github.com/danielmiessler/SecLists/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="95c105f7d6d4b5d70d225472fc132fba"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd SecLists-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	# make DESTDIR=$FAKEROOT/$NAME install
	mkdir -p "$DESTDIR/$NAME/usr/share/wordlists/SecLists"
	install -d -m644 {Discovery,Fuzzing,IOCs,Miscellaneous,Passwords,Pattern-Matching,Payloads,Usernames,Web-Shells} $DESTDIR/$NAME/usr/share/wordlists/SecLists/
}

NAME="dotnet-sdk-6"
DESC="C# developer platform"
VERSION="6.0.404"
SOURCE="https://dotnetcli.azureedge.net/dotnet/Sdk/${VERSION}/dotnet-sdk-${VERSION}-linux-x64.tar.gz"
CHECKSUM="7526cda67ab489576583557eeffc45c4"
DEPS=""
FLAGS="proprietary"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
}

_build()
{
	printf ""
}

_install()
{
	cp -v ./dotnet $FAKEROOT/$NAME/usr/bin/
	cp -vr ./host $FAKEROOT/$NAME/usr/bin/
}

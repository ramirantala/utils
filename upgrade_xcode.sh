#!/bin/bash

if [ -z $APPSTORE_USER ]; then
    echo "Set APPSTORE_USER variable!"
    exit 1
fi

which mas
if [ $? -eq 0 ]; then
	brew upgrade mas
else
	brew install mas
fi

mas signin $APPSTORE_USER $APPSTORE_PASSWORD

xcode_id=`mas list | grep Xcode | cut -d" " -f1`

echo "Upgrading id $xcode_id"
if [ -z $xcode_id ]; then
    echo "could not resolve Xcode id"
    exit 1
fi
mas upgrade $xcode_id

sudo xcodebuild -license accept

for pkg in /Applications/Xcode.app/Contents/Resources/Packages/*.pkg; do sudo installer -pkg "$pkg" -target /; done

brew cask install fastlane

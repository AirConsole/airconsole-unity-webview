#!/bin/bash
DSTDIR="../../package/Runtime/Plugins"
rm -rf DerivedData
xcodebuild -target WebView -configuration Release -arch x86_64 -arch arm64 build CONFIGURATION_BUILD_DIR='DerivedData' | xcbeautify
xcodebuild -target WebViewSeparated -configuration Release -arch x86_64 -arch arm64 build CONFIGURATION_BUILD_DIR='DerivedData' | xcbeautify
mkdir -p $DSTDIR

cp -r DerivedData/WebView.bundle $DSTDIR
cp -r DerivedData/WebViewSeparated.bundle $DSTDIR
rm -rf DerivedData
cp *.bundle.meta $DSTDIR

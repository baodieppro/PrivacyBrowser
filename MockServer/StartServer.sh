#!/bin/sh
cd $SRCROOT/PrivacyBrowserTests/MockServer/Pages
python -m SimpleHTTPServer 8000 &
SERVER_PID=$!
echo $SERVER_PID > $BUILD_DIR/serverpid.txt

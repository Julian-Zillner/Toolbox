#!/bin/bash

REPO_ZIP_URL="https://github.com/Julian-Zillner/Toolbox/archive/refs/heads/main.zip"
INSTALL_DIR="/opt/toolbox"
TMP_ZIP="/tmp/toolbox-main.zip"


mkdir -p "$INSTALL_DIR"


echo "Downloading repository as ZIP..."
curl -L -o "$TMP_ZIP" "$REPO_ZIP_URL"

if [ $? -ne 0 ]; then
    echo "Download failed. Please check your internet connection or the URL."
    exit 1
fi


echo "Extracting ZIP to $INSTALL_DIR ..."
unzip -oq "$TMP_ZIP" -d /tmp/


rm -rf "$INSTALL_DIR"
mv /tmp/Toolbox-main "$INSTALL_DIR"

chmod -R +x "$INSTALL_DIR/Scripts"

rm -f "$TMP_ZIP"

echo "Toolbox installed to: $INSTALL_DIR"
echo "You can run scripts from: $INSTALL_DIR/Scripts"
